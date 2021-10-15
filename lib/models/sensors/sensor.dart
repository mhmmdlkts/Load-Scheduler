import 'package:flutter/material.dart';

abstract class Sensor {
  String name;
  IconData icon;

  Sensor(this.name, this.icon);
  String getDefaultValue();
  String getDefaultUnit();
}