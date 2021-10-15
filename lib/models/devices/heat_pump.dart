import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:load_scheduler/models/devices/devices.dart';

class HeatPump extends Device {
  HeatPump(String name) : super(name, Icons.microwave);

  @override
  String getDefaultUnit() {
    return 'Hours';
  }

  @override
  String getDefaultValue() {
    return '2:17';
  }

}