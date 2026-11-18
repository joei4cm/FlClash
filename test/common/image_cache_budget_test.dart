import 'dart:async';
import 'dart:typed_data';

import 'package:fl_clash/common/image_cache_budget.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(resetImageCacheBudgetForTest);

  test('configureImageCacheBudget tightens Flutter defaults', () {
    configureImageCacheBudget();
    final cache = PaintingBinding.instance.imageCache;
    expect(cache.maximumSizeBytes, imageCacheMaximumSizeBytes);
    expect(cache.maximumSize, imageCacheMaximumSize);
  });

  test('releaseImageCacheBudget clears decoded entries', () async {
    configureImageCacheBudget();
    final cache = PaintingBinding.instance.imageCache;
    final provider = MemoryImage(_onePixelPng);
    final stream = provider.resolve(ImageConfiguration.empty);
    final done = Completer<void>();
    late ImageStreamListener listener;
    listener = ImageStreamListener((image, _) {
      image.dispose();
      stream.removeListener(listener);
      if (!done.isCompleted) {
        done.complete();
      }
    });
    stream.addListener(listener);
    await done.future;
    expect(cache.currentSize, greaterThan(0));
    releaseImageCacheBudget();
    expect(cache.currentSize, 0);
  });
}

// 1×1 transparent PNG.
final _onePixelPng = Uint8List.fromList(<int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
]);
