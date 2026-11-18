package core

import (
	"context"
	"errors"
	"net"
	"testing"

	"github.com/metacubex/mihomo/adapter"
	"github.com/metacubex/mihomo/adapter/outbound"
	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/tunnel"
)

type dialRecordingTailscale struct {
	*outbound.Base
	err      error
	dialedTo string
}

var errWaitForContext = errors.New("wait for context")

func (d *dialRecordingTailscale) DialContext(
	ctx context.Context,
	metadata *constant.Metadata,
) (constant.Conn, error) {
	d.dialedTo = metadata.RemoteAddress()
	if errors.Is(d.err, errWaitForContext) {
		<-ctx.Done()
		return nil, ctx.Err()
	}
	if d.err != nil {
		return nil, d.err
	}
	left, right := net.Pipe()
	go func() {
		_ = right.Close()
	}()
	return outbound.NewConn(left, d), nil
}

func TestHandleTestDelayProbesTailscaleJoinNotPublicURL(t *testing.T) {
	stub := &dialRecordingTailscale{
		Base: outbound.NewBase(outbound.BaseOption{
			Name: "ts-node",
			Type: constant.Tailscale,
		}),
	}
	proxy := adapter.NewProxy(stub)
	tunnel.UpdateProxies(map[string]constant.Proxy{"ts-node": proxy}, nil)
	t.Cleanup(func() { tunnel.UpdateProxies(nil, nil) })

	delay := handleTestDelay(&TestDelayParams{
		ProxyName: "ts-node",
		TestUrl:   defaultTestURL,
		Timeout:   2000,
	})
	if delay == nil {
		t.Fatal("handleTestDelay returned nil")
	}
	if delay.Value <= 0 {
		t.Fatalf("value = %d, want a positive join RTT", delay.Value)
	}
	if stub.dialedTo != tailscaleConfigProbeAddr {
		t.Fatalf("dialed %q, want config probe %q", stub.dialedTo, tailscaleConfigProbeAddr)
	}
	if delay.Url != defaultTestURL {
		t.Fatalf("url = %q, want the requested test URL kept for delay map keys", delay.Url)
	}
}

func TestHandleTestDelayTailscaleJoinFailureIsTimeout(t *testing.T) {
	stub := &dialRecordingTailscale{
		Base: outbound.NewBase(outbound.BaseOption{
			Name: "ts-node",
			Type: constant.Tailscale,
		}),
		err: errWaitForContext,
	}
	proxy := adapter.NewProxy(stub)
	tunnel.UpdateProxies(map[string]constant.Proxy{"ts-node": proxy}, nil)
	t.Cleanup(func() { tunnel.UpdateProxies(nil, nil) })

	delay := handleTestDelay(&TestDelayParams{
		ProxyName: "ts-node",
		Timeout:   50,
	})
	if delay == nil {
		t.Fatal("handleTestDelay returned nil")
	}
	if delay.Value != delayTimedOut {
		t.Fatalf("value = %d, want timeout %d", delay.Value, delayTimedOut)
	}
}

func TestHandleTestDelayTailscaleDialErrorIsFailure(t *testing.T) {
	stub := &dialRecordingTailscale{
		Base: outbound.NewBase(outbound.BaseOption{
			Name: "ts-node",
			Type: constant.Tailscale,
		}),
		err: errors.New("auth rejected"),
	}
	proxy := adapter.NewProxy(stub)
	tunnel.UpdateProxies(map[string]constant.Proxy{"ts-node": proxy}, nil)
	t.Cleanup(func() { tunnel.UpdateProxies(nil, nil) })

	delay := handleTestDelay(&TestDelayParams{ProxyName: "ts-node", Timeout: 2000})
	if delay == nil {
		t.Fatal("handleTestDelay returned nil")
	}
	if delay.Value != delayFailed {
		t.Fatalf("value = %d, want failure %d", delay.Value, delayFailed)
	}
}
