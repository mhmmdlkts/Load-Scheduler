import 'package:load_scheduler/models/sensors/sensor.dart';
import 'package:flutter/material.dart';

class TankLevel extends Sensor {
  TankLevel(String name, IconData icon) : super(name, icon);
  double level = 0.85256;

  @override
  String getDefaultValue() {
    return (level * 100).toStringAsFixed(2) + ' ' + getDefaultUnit();
  }

  @override
  String getDefaultUnit() {
    return '%';
  }
}