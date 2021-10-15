import 'package:flutter/material.dart';
import 'package:load_scheduler/models/devices/devices.dart';

class Pump extends Device {
  Pump(String name) : super(name, Icons.wb_iridescent_rounded);

  @override
  String getDefaultUnit() {
    return 'Hours';
  }

  @override
  String getDefaultValue() {
    return '0:32';
  }
}