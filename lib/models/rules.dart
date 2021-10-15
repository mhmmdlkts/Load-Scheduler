import 'package:load_scheduler/enums/rule_action.dart';
import 'package:load_scheduler/enums/rules_condition.dart';
import 'package:load_scheduler/models/rule.dart';

class Rules {
  final List<Rule> _rules = [];
  RulesConditionEnum rulesConditionEnum = RulesConditionEnum.and;
  RuleActionEnum ruleActionEnum = RuleActionEnum.start;

  void addRule(Rule rule) {
    _rules.add(rule);
  }

  length() => _rules.length;

  Rule getRule(int index) => _rules[index];

  static String rulesConditionToText(RulesConditionEnum condition) {
    switch (condition) {
      case RulesConditionEnum.and:
        return 'AND';
      case RulesConditionEnum.or:
        return 'OR';
      default:
        return '';
    }
  }

  bool existRules() => _rules.isNotEmpty;
}