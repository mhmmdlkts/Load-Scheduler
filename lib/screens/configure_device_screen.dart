import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:load_scheduler/enums/rule_action.dart';
import 'package:load_scheduler/enums/rules_condition.dart';
import 'package:load_scheduler/enums/working_mode_enum.dart';
import 'package:load_scheduler/models/devices/devices.dart';
import 'package:load_scheduler/models/rule.dart';
import 'package:load_scheduler/models/rules.dart';
import 'package:load_scheduler/screens/add_rule_screen.dart';
import 'package:load_scheduler/services/devices_service.dart';

class ConfigureDeviceScreen extends StatefulWidget {
  final Device device;
  const ConfigureDeviceScreen({Key key, this.device}) : super(key: key);

  @override
  State<ConfigureDeviceScreen> createState() => _ConfigureDeviceScreenState();
}

class _ConfigureDeviceScreenState extends State<ConfigureDeviceScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Visibility(
              visible: WorkingModeEnum.rules == widget.device.workingMode,
              child: _addRuleButton(),
            ),
            Column(
              children: [
                Container(height: 10,),
                AnimatedToggleSwitch<WorkingModeEnum>.rolling(
                  current: widget.device.workingMode,
                  values: const [WorkingModeEnum.off, WorkingModeEnum.on, WorkingModeEnum.rules],
                  onChanged: (mode) => setState(() => widget.device.workingMode = mode),
                  iconBuilder: iconBuilder,
                ),
                ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  children: [
                    _getContent()
                  ],
                ),
              ],
            )
          ],
        )
      )
    );
  }

  Icon iconBuilder(WorkingModeEnum mode, Size size, bool active) {
    return Device.getIcon(mode);
  }

  Widget _getContent() {
    switch (widget.device.workingMode) {
      case WorkingModeEnum.on:
        return _getDeviceOnWidget();
      case WorkingModeEnum.off:
        return _getDeviceOffWidget();
      case WorkingModeEnum.rules:
        return Visibility(
          visible: widget.device.rules.existRules(),
          child: _getDeviceRulesWidget(),
        );
      default:
        return Container();
    }
  }

  Widget _getDeviceOnWidget() => Container(
    padding: const EdgeInsets.only(top: 50),
    child: _getCircleWIthText(Colors.green, 'On')
  );

  Widget _getDeviceOffWidget() => Container(
    padding: const EdgeInsets.only(top: 50),
    child: _getCircleWIthText(Colors.red, 'Off')
  );

  Widget _getCircleWIthText(Color color, String text) => Center(
    child: Container(
        width: MediaQuery.of(context).size.width - 200,
        height: MediaQuery.of(context).size.width - 200,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(800))
        ),
        child: Center(
          child: Text(text, style: TextStyle(color: Colors.white, fontSize: 40),),
        )
    ),
  );

  Widget _getDeviceRulesWidget() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() {
              if (widget.device.rules.ruleActionEnum == RuleActionEnum.start) {
                widget.device.rules.ruleActionEnum = RuleActionEnum.stop;
              } else {
                widget.device.rules.ruleActionEnum = RuleActionEnum.start;
              }
            }),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: (widget.device.rules.rulesConditionEnum==RulesConditionEnum.or?'When at least one of the following conditions is true':'When all of the following conditions are true' ) + ' then the ' + widget.device.name.toLowerCase() + ' will',
                style: TextStyle(color: Colors.black, fontSize: 20),
                children: <TextSpan>[
                  widget.device.rules.ruleActionEnum == RuleActionEnum.start?
                  const TextSpan(text: ' run', style: TextStyle(color: Colors.blue)):
                  const TextSpan(text: ' not run', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ),
          Container(height: 20,),
          ListView.separated(
              shrinkWrap: true,
              itemCount: widget.device.rules.length(),
              itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: getRuleItemWidget(widget.device.rules.getRule(index))
              ),
              separatorBuilder: (BuildContext context, int index) => InkWell(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Divider(thickness: 1, height: 1,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      child: Text(Rules.rulesConditionToText(widget.device.rules.rulesConditionEnum,), style: TextStyle(backgroundColor: Colors.white, color: Colors.blue),),
                    )
                  ],
                ),
                onTap: () async {
                  setState(() {
                    if (widget.device.rules.rulesConditionEnum == RulesConditionEnum.and) {
                      widget.device.rules.rulesConditionEnum = RulesConditionEnum.or;
                    } else {
                      widget.device.rules.rulesConditionEnum = RulesConditionEnum.and;
                    }
                  });
                },
              )
          ),
        ],
      ),
    );
  }

  Widget _addRuleButton() => Positioned(
    bottom: 50,
    height: 50,
    width: MediaQuery.of(context).size.width - 100,
    child: ElevatedButton(
        onPressed: () async {
          Rule rule = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRuleScreen()),
          );
          if (rule != null) {
            setState(() {
              widget.device.rules.addRule(rule);
            });
          }
        },
        child: const Text('Add new rule')
    ),
  );

  Widget getRuleItemWidget(Rule rule) => Row(
    children: [
      Expanded(
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(rule.sensor.name),
        ),
      ),
      Expanded(
        child: Container(
          alignment: Alignment.center,
          child: Text(Rule.ruleConditionToText(rule.condition)),
        ),
      ),
      Expanded(
        child: Container(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text((rule?.value?.toStringAsFixed(1)??'0.0') + ' ' + rule.sensor.getDefaultUnit()),
              Container(width: 10,),
              Icon(rule.sensor.icon)
            ],
          ),
        ),
      ),
    ],
  );
}
