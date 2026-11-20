import 'dart:typed_data';

import 'package:test/test.dart';

import '../../../tool/neo/ipc.dart';

void main() {
  test('round-trips a framed payload', () {
    final encoded = NeoIpcFrame.encode(utf8Bytes('hello'));
    final reader = NeoIpcReader()..add(encoded);
    final frames = reader.takeFrames();
    expect(frames, hasLength(1));
    expect(String.fromCharCodes(frames.single), 'hello');
  });

  test('buffers a partial frame until complete', () {
    final encoded = NeoIpcFrame.encode(utf8Bytes('abcdef'));
    final reader = NeoIpcReader()..add(encoded.sublist(0, 3));
    expect(reader.takeFrames(), isEmpty);
    reader.add(encoded.sublist(3));
    final frames = reader.takeFrames();
    expect(frames, hasLength(1));
    expect(String.fromCharCodes(frames.single), 'abcdef');
  });
}

Uint8List utf8Bytes(String value) => Uint8List.fromList(value.codeUnits);
