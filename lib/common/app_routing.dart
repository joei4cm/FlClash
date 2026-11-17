import 'package:fl_clash/common/snowflake.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/clash_config.dart';

/// PROCESS-NAME* rules used by the App routing screen.
bool isProcessRoutingRule(Rule rule) {
  return switch (rule.ruleAction) {
    RuleAction.PROCESS_NAME ||
    RuleAction.PROCESS_NAME_REGEX ||
    RuleAction.PROCESS_NAME_WILDCARD => true,
    _ => false,
  };
}

List<Rule> processRoutingRules(Iterable<Rule> rules) {
  return [
    for (final rule in rules)
      if (isProcessRoutingRule(rule)) rule,
  ];
}

Rule buildProcessRoutingRule({
  required String processName,
  required String target,
  RuleAction action = RuleAction.PROCESS_NAME,
  int? id,
}) {
  return Rule(
    id: id ?? snowflake.id,
    ruleAction: action,
    content: processName.trim(),
    ruleTarget: target.trim(),
  );
}
