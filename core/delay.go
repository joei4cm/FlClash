package core

import (
	"context"
	"slices"
	"sync/atomic"
	"time"

	"github.com/metacubex/mihomo/common/utils"
	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/tunnel"
)

const (
	delayTestConcurrency    = 50
	defaultTestURL          = "https://www.gstatic.com/generate_204"
	defaultDelayTestTimeout = 5 * time.Second
	// Cold Tailscale join (auth + netstack + IP assignment) often exceeds the
	// app’s ≤8s delay-test options. Raise those so the node-test button can
	// finish; keep explicit sub-second timeouts for unit tests.
	defaultTailscaleJoinTimeout = 25 * time.Second
	// Fallback when ProbeJoin is unavailable: MagicDNS TCP. Prefer ProbeJoin —
	// many builds have no TCP listener on 100.100.100.100:53.
	tailscaleConfigProbeAddr = "100.100.100.100:53"
)

var (
	delayTestSlots     = make(slots, delayTestConcurrency)
	anyDelayTestStatus utils.IntRanges[uint16]

	testURL                 atomic.Pointer[string]
	missingDelayTestProxyAt atomic.Int64
)

func setTestURL(url string) {
	if url == "" {
		return
	}
	constant.DefaultTestURL = url
	testURL.Store(&url)
}

func currentTestURL() string {
	if url := testURL.Load(); url != nil && *url != "" {
		return *url
	}
	return defaultTestURL
}

const (
	delayTimedOut int32 = -1
	delayFailed   int32 = -2
)

func delayValue(delay uint16, timedOut bool) int32 {
	switch {
	case delay > 0:
		return int32(delay)
	case timedOut:
		return delayTimedOut
	default:
		return delayFailed
	}
}

// A name the tunnel does not know is what an apply that fell back to the
// default config looks like: every node of the profile fails its test. Say so
// once a second, not once per node, so the log names the real failure.
func reportMissingDelayTestProxy(name string) {
	now := time.Now().UnixNano()
	last := missingDelayTestProxyAt.Load()
	if last != 0 && now-last < int64(time.Second) {
		return
	}
	if !missingDelayTestProxyAt.CompareAndSwap(last, now) {
		return
	}
	logError("delay test: %q is not part of the applied config", name)
}

// A nil answer means the test never got a slot, which says nothing about the proxy.
func handleTestDelay(params *TestDelayParams) *Delay {
	url := params.TestUrl
	if url == "" {
		url = currentTestURL()
	}
	result := &Delay{Name: params.ProxyName, Url: url, Value: delayFailed}

	proxy := lookupProxy(params.ProxyName)
	if proxy == nil {
		reportMissingDelayTestProxy(params.ProxyName)
		return result
	}

	timeout, configured := configuredTestTimeout(proxy.Name(), url)
	if !configured {
		timeout = timeoutFromMillis(params.Timeout, defaultDelayTestTimeout)
	}
	if proxy.Type() == constant.Tailscale && !configured {
		// App settings only offer ≤8s; raise those so a cold join can finish.
		// Explicit short timeouts (unit tests) stay as-is.
		if timeout >= time.Second && timeout < defaultTailscaleJoinTimeout {
			timeout = defaultTailscaleJoinTimeout
		}
	}
	if !delayTestSlots.acquireWithin(context.Background(), timeout) {
		return nil
	}
	defer delayTestSlots.release()

	ctx, cancel := context.WithTimeout(context.Background(), timeout)
	defer cancel()
	if proxy.Type() == constant.Tailscale {
		return probeTailscaleConfig(ctx, proxy, result)
	}
	delay, err := proxy.URLTest(ctx, url, anyDelayTestStatus)
	if err != nil {
		delay = 0
	}
	result.Value = delayValue(delay, ctx.Err() != nil)
	return result
}

type tailscaleJoinProber interface {
	ProbeJoin(ctx context.Context) error
}

func asTailscaleJoinProber(proxy constant.Proxy) (tailscaleJoinProber, bool) {
	if prober, ok := proxy.(tailscaleJoinProber); ok {
		return prober, true
	}
	if adapter, ok := proxy.(interface{ Adapter() constant.ProxyAdapter }); ok {
		if prober, ok := adapter.Adapter().(tailscaleJoinProber); ok {
			return prober, true
		}
	}
	return nil, false
}

// probeTailscaleConfig checks that the embedded Tailscale outbound has joined
// the tailnet. The usual URLTest target is a public generate_204 URL, which
// only works when an exit node is set, so a healthy peer-only node always
// looked "timed out" even after a successful join.
func probeTailscaleConfig(ctx context.Context, proxy constant.Proxy, result *Delay) *Delay {
	start := time.Now()
	if prober, ok := asTailscaleJoinProber(proxy); ok {
		if err := prober.ProbeJoin(ctx); err != nil {
			result.Value = delayValue(0, ctx.Err() != nil)
			return result
		}
		elapsed := time.Since(start) / time.Millisecond
		if elapsed == 0 {
			elapsed = 1
		}
		result.Value = int32(elapsed)
		return result
	}

	// Stubs / older adapters without ProbeJoin: fall back to MagicDNS TCP.
	metadata := &constant.Metadata{NetWork: constant.TCP}
	if err := metadata.SetRemoteAddress(tailscaleConfigProbeAddr); err != nil {
		result.Value = delayFailed
		return result
	}
	conn, err := proxy.DialContext(ctx, metadata)
	if err != nil {
		result.Value = delayValue(0, ctx.Err() != nil)
		return result
	}
	_ = conn.Close()
	elapsed := time.Since(start) / time.Millisecond
	if elapsed == 0 {
		elapsed = 1
	}
	result.Value = int32(elapsed)
	return result
}

type testTimeoutProvider interface {
	TestTimeout(url string) (time.Duration, bool)
}

// The longest stands, so no scheduled check passes a node the manual test fails.
func configuredTestTimeout(name, url string) (time.Duration, bool) {
	var longest time.Duration
	for _, pd := range tunnel.ProvidersSnapshot() {
		timed, ok := pd.(testTimeoutProvider)
		if !ok {
			continue
		}
		timeout, ok := timed.TestTimeout(url)
		if !ok || timeout <= longest {
			continue
		}
		if slices.ContainsFunc(pd.Proxies(), func(p constant.Proxy) bool { return p.Name() == name }) {
			longest = timeout
		}
	}
	return longest, longest > 0
}
