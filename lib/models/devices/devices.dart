import 'dart:math';

import 'package:load_scheduler/enums/working_mode_enum.dart';
import 'package:flutter/material.dart';
import 'package:load_scheduler/models/sensors/sensor.dart';

import '../rules.dart';

abstract class Device extends Sensor{
  WorkingModeEnum workingMode = WorkingModeEnum.off;
  String name;
  IconData icon;
  int level = -1;
  Rules rules = Rules();
  List<double> workingLevels = [];

  Device(this.name, this.icon) : super(name, icon);

  static Widget getIcon(WorkingModeEnum mode) {
    switch (mode) {
      case WorkingModeEnum.on:
        return const Icon(
          Icons.looks_one,
        );
      case WorkingModeEnum.off:
        return const Icon(
          Icons.exposure_zero,
        );
      case WorkingModeEnum.rules:
        return const Icon(
          Icons.rule_sharp,
        );
    }
    return Container();
  }

  double getUsage() => workingLevels[level];

  static getWorkingIcon(WorkingModeEnum mode) {
    switch (mode) {
      case WorkingModeEnum.on:
        return const Icon(
          Icons.looks_one,
          color: Colors.green,
        );
      case WorkingModeEnum.off:
        return const Icon(
          Icons.exposure_zero,
          color: Colors.red,
        );
      case WorkingModeEnum.rules:
        return Icon(
          Icons.rule_sharp,
          color: Random().nextInt(2) != 1?Colors.green:Colors.red,
        );
    }
    return Container();
  }
}