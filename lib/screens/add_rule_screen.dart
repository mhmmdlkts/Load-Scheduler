import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load_scheduler/enums/rule_condition.dart';
import 'package:load_scheduler/models/devices/devices.dart';
import 'package:load_scheduler/models/devices/hether.dart';
import 'package:load_scheduler/models/devices/pump.dart';
import 'package:load_scheduler/models/rule.dart';
import 'package:load_scheduler/models/sensors/sensor.dart';
import 'package:load_scheduler/services/devices_service.dart';
import 'package:load_scheduler/services/sensors_service.dart';

class AddRuleScreen extends StatefulWidget {
  const AddRuleScreen({Key key}) : super(key: key);

  @override
  State<AddRuleScreen> createState() => _AddRuleScreenState();
}

class _AddRuleScreenState extends State<AddRuleScreen> {

  List<Sensor> sensors = [];
  RuleConditionEnum condition = RuleConditionEnum.greater;
  double value = 0.0;
  Sensor sensor;

  @override
  void initState() {
    super.initState();
    SensorsService.sensors.forEach((element) {
      sensors.add(element);
    });
    DevicesService.allDevices.forEach((element) {
      sensors.add(element);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new rule'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_next),
        onPressed: () {
          Rule rule = Rule(sensor, value, condition);
          Navigator.pop(context, rule);
        },
      ),
      body: sensor == null? _sensorContent():_bContent()
    );
  }

  Widget _bContent() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Text(sensor.name),
            onTap: () {
              setState(() {
                sensor = null;
              });
            },
          ),
          DropdownButton<RuleConditionEnum>(
            value: condition,
            items: RuleConditionEnum.values.map((RuleConditionEnum value) {
              return DropdownMenuItem<RuleConditionEnum>(
                value: value,
                child: Text(Rule.ruleConditionToText(value)),
              );
            }).toList(),
            onChanged: (condition) {
              setState(() {
                this.condition = condition;
              });
            },
          ),
          Container(
            width: 150.0,
            child: TextField(
              onChanged: (val) {
                try {
                  value = double.parse(val);
                } catch (e) {
                  value = 0;
                }
              },
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter,//No line break
                FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
              ],
              decoration:  InputDecoration(
              hintText: '0.0',
              // show kg
              suffixText: sensor.getDefaultUnit(),
            )
          ),
          )
        ],
      ),
    );
  }

  Widget _sensorContent() {
    return ListView(
      children: [
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: sensors.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                sensor = sensors[index];
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(sensors[index].name),
                  Icon(sensors[index].icon)
                ],
              ),
            ),
          ),
          separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1,height: 1,),
        ),
      ],
    );
  }
}
