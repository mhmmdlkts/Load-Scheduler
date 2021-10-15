import 'package:load_scheduler/models/sensors/sensor.dart';
import 'package:flutter/material.dart';

class TempOutside extends Sensor {
  TempOutside(String name, IconData icon) : super(name, icon);
  double temp = 12.145;

  @override
  String getDefaultValue() {
    return temp.toStringAsFixed(1) + ' ' + getDefaultUnit();
  }

  @override
  String getDefaultUnit() {
    return '°C';
  }
}