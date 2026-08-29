import 'package:fl_clash/common/service_probe.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('service probe catalog covers expected categories', () {
    expect(
      ServiceProbeCategory.values.every(
        (category) => category.probes.isNotEmpty,
      ),
      isTrue,
    );
    final brands = serviceProbes.map((probe) => probe.brand).toSet();
    expect(
      brands,
      containsAll([
        'Google',
        'Reddit',
        'Discord',
        'ChatGPT',
        'Netflix',
        'Apple TV',
      ]),
    );
    expect(
      serviceProbes.map((probe) => probe.id).toSet().length,
      serviceProbes.length,
    );
    expect(
      serviceProbes.every(
        (probe) => Uri.tryParse(probe.url)?.hasScheme == true,
      ),
      isTrue,
    );
  });
}
