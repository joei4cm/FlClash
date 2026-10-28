import 'package:fl_clash/common/clash_identifiers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isSafeClashField', () {
    test('accepts ordinary proxy and domain names', () {
      expect(isSafeClashField('US-01'), isTrue);
      expect(isSafeClashField('home.ts.net'), isTrue);
      expect(isSafeClashField('  trimmed  '), isTrue);
    });

    test('rejects empty, commas, and control characters', () {
      expect(isSafeClashField(''), isFalse);
      expect(isSafeClashField('   '), isFalse);
      expect(isSafeClashField('a,b'), isFalse);
      expect(isSafeClashField('a\nb'), isFalse);
      expect(isSafeClashField('a\x00b'), isFalse);
    });
  });

  group('isValidIanaTimezoneId', () {
    test('accepts Area/Location and UTC aliases', () {
      expect(isValidIanaTimezoneId('America/Los_Angeles'), isTrue);
      expect(isValidIanaTimezoneId('Asia/Shanghai'), isTrue);
      expect(isValidIanaTimezoneId('UTC'), isTrue);
      expect(isValidIanaTimezoneId('Etc/UTC'), isTrue);
    });

    test('rejects shell metacharacters and bare regions', () {
      expect(isValidIanaTimezoneId('America/Los_Angeles;id'), isFalse);
      expect(isValidIanaTimezoneId(r'$(reboot)'), isFalse);
      expect(isValidIanaTimezoneId('America'), isFalse);
      expect(isValidIanaTimezoneId(''), isFalse);
    });
  });

  group('isSafeTailscaleControlUrl', () {
    test('allows empty and https hosts without userinfo', () {
      expect(isSafeTailscaleControlUrl(''), isTrue);
      expect(
        isSafeTailscaleControlUrl('https://controlplane.tailscale.com'),
        isTrue,
      );
    });

    test('rejects non-https and credentialed URLs', () {
      expect(isSafeTailscaleControlUrl('http://example.com'), isFalse);
      expect(
        isSafeTailscaleControlUrl('https://user:pass@example.com'),
        isFalse,
      );
      expect(isSafeTailscaleControlUrl('not a url'), isFalse);
    });
  });

  group('isSafeTailscaleStateDir', () {
    test('allows empty and ordinary paths', () {
      expect(isSafeTailscaleStateDir(''), isTrue);
      expect(isSafeTailscaleStateDir('/var/lib/tailscale'), isTrue);
      expect(isSafeTailscaleStateDir('tailscale-state'), isTrue);
    });

    test('rejects traversal and NUL', () {
      expect(isSafeTailscaleStateDir('../escape'), isFalse);
      expect(isSafeTailscaleStateDir('a\x00b'), isFalse);
    });
  });
}
