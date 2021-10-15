import 'package:flutter/cupertino.dart';
import 'package:load_scheduler/models/sensors/sensor.dart';

class BatteryLevel extends Sensor {
  BatteryLevel(String name, IconData icon) : super(name, icon);
  double level = 0.642456;

  @override
  String getDefaultValue() {
    return (level * 100).toStringAsFixed(2) + ' ' + getDefaultUnit();
  }

  @override
  String getDefaultUnit() {
    return '%';
  }

}