//go:build android && cgo

package tun

import "C"
import (
	"net"
	"net/netip"
	"strings"
	"syscall"

	"github.com/metacubex/mihomo/constant"
	LC "github.com/metacubex/mihomo/listener/config"
	"github.com/metacubex/mihomo/listener/sing_tun"
	"github.com/metacubex/mihomo/log"
	"github.com/metacubex/mihomo/tunnel"
)

// Start takes ownership of fd. It hands it to sing-tun once the options
// validate; until then a failure has to close it here, since the descriptor was
// detached from its ParcelFileDescriptor on the Android side and nothing else
// still refers to it.
func Start(fd int, stack string, address, dns string) *sing_tun.Listener {
	var prefix4 []netip.Prefix
	var prefix6 []netip.Prefix
	tunStack, ok := constant.StackTypeMapping[strings.ToLower(stack)]
	if !ok {
		tunStack = constant.TunSystem
	}
	for _, a := range strings.Split(address, ",") {
		a = strings.TrimSpace(a)
		if len(a) == 0 {
			continue
		}
		prefix, err := netip.ParsePrefix(a)
		if err != nil {
			log.Errorln("TUN: %v", err)
			_ = syscall.Close(fd)
			return nil
		}
		if prefix.Addr().Is4() {
			prefix4 = append(prefix4, prefix)
		} else {
			prefix6 = append(prefix6, prefix)
		}
	}

	var dnsHijack []string
	for _, d := range strings.Split(dns, ",") {
		d = strings.TrimSpace(d)
		if len(d) == 0 {
			continue
		}
		dnsHijack = append(dnsHijack, net.JoinHostPort(d, "53"))
	}

	options := LC.Tun{
		Enable:              true,
		Device:              "FlClash",
		Stack:               tunStack,
		DNSHijack:           dnsHijack,
		AutoRoute:           false,
		AutoDetectInterface: false,
		Inet4Address:        prefix4,
		Inet6Address:        prefix6,
		MTU:                 9000,
		FileDescriptor:      fd,
	}

	listener, err := sing_tun.New(options, tunnel.Tunnel)

	if err != nil {
		// fd went to sing-tun with the options; whether it got as far as
		// wrapping the descriptor is not observable from here, so closing it
		// again risks freeing a number something else has already been handed.
		// The caller tears the VPN down instead, which reclaims the interface.
		log.Errorln("TUN: %v", err)
		return nil
	}

	return listener
}
