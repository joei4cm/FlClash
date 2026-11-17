import 'package:flutter_test/flutter_test.dart';

import '../../../tool/tui/keys.dart';

void main() {
  test('parses printable chars and enter', () {
    expect(parseKey([97]).matchesChar('a'), isTrue);
    expect(parseKey([13]).kind, KeyKind.enter);
    expect(parseKey([10]).kind, KeyKind.enter);
  });

  test('parses arrows and ctrl keys', () {
    expect(parseKey([27, 91, 65]).kind, KeyKind.up);
    expect(parseKey([27, 91, 66]).kind, KeyKind.down);
    expect(parseKey([27]).kind, KeyKind.escape);
    expect(parseKey([21]).kind, KeyKind.clearLine);
    expect(parseKey([127]).kind, KeyKind.backspace);
  });

  test('mayNeedMoreBytes for CSI sequences', () {
    expect(mayNeedMoreBytes([27]), isTrue);
    expect(mayNeedMoreBytes([27, 91]), isTrue);
    expect(mayNeedMoreBytes([27, 91, 65]), isFalse);
    expect(mayNeedMoreBytes([97]), isFalse);
  });
}
