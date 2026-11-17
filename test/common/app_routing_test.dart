import 'package:fl_clash/common/app_routing.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/clash_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('isProcessRoutingRule matches PROCESS-NAME variants only', () {
    expect(
      isProcessRoutingRule(
        const Rule(
          ruleAction: RuleAction.PROCESS_NAME,
          content: 'chrome',
          ruleTarget: 'DIRECT',
        ),
      ),
      isTrue,
    );
    expect(
      isProcessRoutingRule(
        const Rule(
          ruleAction: RuleAction.PROCESS_NAME_WILDCARD,
          content: 'chrome*',
          ruleTarget: 'DIRECT',
        ),
      ),
      isTrue,
    );
    expect(
      isProcessRoutingRule(
        const Rule(
          ruleAction: RuleAction.DOMAIN,
          content: 'example.com',
          ruleTarget: 'DIRECT',
        ),
      ),
      isFalse,
    );
  });

  test('processRoutingRules filters mixed lists', () {
    final rules = processRoutingRules([
      const Rule(
        id: 1,
        ruleAction: RuleAction.DOMAIN,
        content: 'a.com',
        ruleTarget: 'DIRECT',
      ),
      const Rule(
        id: 2,
        ruleAction: RuleAction.PROCESS_NAME,
        content: 'Cursor',
        ruleTarget: 'PROXY',
      ),
      const Rule(
        id: 3,
        ruleAction: RuleAction.PROCESS_NAME_REGEX,
        content: 'chrome.*',
        ruleTarget: 'DIRECT',
      ),
    ]);
    expect(rules.map((rule) => rule.id), [2, 3]);
  });

  test('buildProcessRoutingRule trims and sets PROCESS-NAME', () {
    final rule = buildProcessRoutingRule(
      id: 42,
      processName: '  Cursor  ',
      target: ' DIRECT ',
    );
    expect(rule.id, 42);
    expect(rule.ruleAction, RuleAction.PROCESS_NAME);
    expect(rule.content, 'Cursor');
    expect(rule.ruleTarget, 'DIRECT');
  });
}
