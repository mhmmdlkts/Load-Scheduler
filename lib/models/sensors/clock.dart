import 'package:flutter/cupertino.dart';
import 'package:load_scheduler/models/sensors/sensor.dart';
import 'package:intl/intl.dart';

class Clock extends Sensor {
  Clock(String name, IconData icon) : super(name, icon);

  @override
  String getDefaultValue() {
    DateTime now = DateTime.now();
    return DateFormat('hh:mm a').format(now);
  }

  @override
  String getDefaultUnit() {
    return '';
  }

}