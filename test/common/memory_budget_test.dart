import 'package:fl_clash/common/constant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('live UI lists stay below previous multi-thousand caps', () {
    expect(maxLogsLength, lessThanOrEqualTo(2000));
    expect(maxRequestsLength, lessThanOrEqualTo(1500));
    expect(maxDnsQueriesLength, lessThanOrEqualTo(2000));
    expect(maxLiveConnectionsLength, lessThanOrEqualTo(1000));
    expect(pausedMaxLogsLength, maxLogsLength * 2);
    expect(pausedMaxRequestsLength, maxRequestsLength * 2);
  });
}
