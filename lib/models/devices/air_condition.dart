import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:load_scheduler/models/devices/devices.dart';

class AirCondition extends Device {
  AirCondition(String name) : super(name, Icons.air);

  @override
  String getDefaultUnit() {
    return 'Hours';
  }

  @override
  String getDefaultValue() {
    return '2:32';
  }

}