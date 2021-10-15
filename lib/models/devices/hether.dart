import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:load_scheduler/models/devices/devices.dart';

class Heater extends Device {
  Heater(String name) : super(name, Icons.local_fire_department);

  @override
  String getDefaultUnit() {
    return 'Hours';
  }

  @override
  String getDefaultValue() {
    return '3:32';
  }

}