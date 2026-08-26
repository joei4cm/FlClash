import 'package:fl_clash/core/event.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

class _RecordingListener with CoreEventListener {
  _RecordingListener({this.throwOnTraffic = false});

  final List<CoreEventType> received = [];
  final bool throwOnTraffic;

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
  test('CoreEventManager keeps dispatching after a listener throws', () async {
    final listener = _RecordingListener(throwOnTraffic: true);
    coreEventManager.addListener(listener);
    addTearDown(() => coreEventManager.removeListener(listener));

    coreEventManager.sendEvent(
      const CoreEvent(
        type: CoreEventType.traffic,
        data: {'up': 1, 'down': 2},
      ),
    );
    coreEventManager.sendEvent(
      const CoreEvent(
        type: CoreEventType.delay,
        data: {'url': 'https://example.com', 'name': 'proxy', 'value': 12},
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(listener.received, [CoreEventType.delay]);
  });
}
