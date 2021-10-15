import 'package:load_scheduler/models/sensors/sensor.dart';
import 'package:flutter/material.dart';

class TempInside extends Sensor {
  TempInside(String name, IconData icon) : super(name, icon);
  double temp = 20.5245;

  @override
  String getDefaultValue() {
    return temp.toStringAsFixed(1) + ' ' + getDefaultUnit();
  }

  @override
  String getDefaultUnit() {
    return '°C';
  }
}