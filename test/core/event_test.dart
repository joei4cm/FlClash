import 'package:fl_clash/core/event.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

class _RecordingListener with CoreEventListener {
  _RecordingListener({this.onLoadedCallback, this.throwOnTraffic = false});

  final void Function()? onLoadedCallback;
  final bool throwOnTraffic;
  final List<String> loaded = [];
  final List<CoreEventType> received = [];

  @override
  void onLoaded(String providerName) {
    loaded.add(providerName);
    onLoadedCallback?.call();
  }

  @override
  void onTraffic(Map<String, dynamic> snapshot) {
    if (throwOnTraffic) {
      throw StateError('boom');
    }
    received.add(CoreEventType.traffic);
  }

  @override
  void onDelay(Delay delay) {
    received.add(CoreEventType.delay);
  }
}

void main() {
  test(
    'a listener may unregister itself while an event is dispatched',
    () async {
      late _RecordingListener first;
      final second = _RecordingListener();
      first = _RecordingListener(
        onLoadedCallback: () => coreEventManager.removeListener(first),
      );

      coreEventManager.addListener(first);
      coreEventManager.addListener(second);
      addTearDown(() {
        coreEventManager.removeListener(first);
        coreEventManager.removeListener(second);
      });

      coreEventManager.sendEvent(
        const CoreEvent(type: CoreEventType.loaded, data: 'provider-a'),
      );
      await pumpEventQueue();

      expect(first.loaded, ['provider-a']);
      expect(second.loaded, ['provider-a']);

      coreEventManager.sendEvent(
        const CoreEvent(type: CoreEventType.loaded, data: 'provider-b'),
      );
      await pumpEventQueue();

      expect(first.loaded, ['provider-a']);
      expect(second.loaded, ['provider-a', 'provider-b']);
    },
  );

  test('CoreEventManager keeps dispatching after a listener throws', () async {
    final listener = _RecordingListener(throwOnTraffic: true);
    coreEventManager.addListener(listener);
    addTearDown(() => coreEventManager.removeListener(listener));

    coreEventManager.sendEvent(
      const CoreEvent(type: CoreEventType.traffic, data: {'up': 1, 'down': 2}),
    );
    coreEventManager.sendEvent(
      const CoreEvent(
        type: CoreEventType.delay,
        data: {'url': 'https://example.com', 'name': 'proxy', 'value': 12},
      ),
    );

    await pumpEventQueue();
    expect(listener.received, [CoreEventType.delay]);
  });
}
