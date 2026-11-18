import 'package:flutter/painting.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;

/// Flutter's default image cache is 100 MiB. Tray icons and remote covers are
/// already decoded at a small extent, so a tighter budget keeps idle RSS down.
const imageCacheMaximumSizeBytes = 32 << 20;
const imageCacheMaximumSize = 200;

/// Caps the process-wide [ImageCache] used by [Image] / [precacheImage].
void configureImageCacheBudget({
  int maximumSizeBytes = imageCacheMaximumSizeBytes,
  int maximumSize = imageCacheMaximumSize,
}) {
  final cache = PaintingBinding.instance.imageCache;
  cache.maximumSizeBytes = maximumSizeBytes;
  cache.maximumSize = maximumSize;
}

/// Drops decoded bitmaps while the UI is hidden (tray / background).
void releaseImageCacheBudget() {
  final cache = PaintingBinding.instance.imageCache;
  cache.clear();
  cache.clearLiveImages();
}

@visibleForTesting
void resetImageCacheBudgetForTest() {
  final cache = PaintingBinding.instance.imageCache;
  cache.maximumSizeBytes = 100 << 20;
  cache.maximumSize = 1000;
  cache.clear();
  cache.clearLiveImages();
}
