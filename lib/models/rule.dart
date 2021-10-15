import 'package:load_scheduler/enums/rule_condition.dart';
import 'package:load_scheduler/enums/rule_action.dart';
import 'package:load_scheduler/models/sensors/sensor.dart';

class Rule {

  Sensor sensor;
  double value;
  RuleConditionEnum condition;

  Rule(this.sensor, this.value, this.condition);

  static String ruleActionToText(RuleActionEnum condition) {
    switch (condition) {
      case RuleActionEnum.start:
        return 'start';
      case RuleActionEnum.stop:
        return 'stop';
      default:
        return '';
    }
  }

  static String ruleConditionToText(RuleConditionEnum condition) {
    switch (condition) {
      case RuleConditionEnum.equal:
        return '==';
      case RuleConditionEnum.notEqual:
        return '!=';
      case RuleConditionEnum.greater:
        return '>';
      case RuleConditionEnum.less:
        return '<';
      case RuleConditionEnum.greaterEqual:
        return '>=';
      case RuleConditionEnum.lessEqual:
        return '<=';
      default:
        return '';
    }
  }
}