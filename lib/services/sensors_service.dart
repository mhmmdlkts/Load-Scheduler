import 'package:load_scheduler/models/sensors/battery_level.dart';
import 'package:load_scheduler/models/sensors/clock.dart';
import 'package:load_scheduler/models/sensors/sensor.dart';
import 'package:flutter/material.dart';
import 'package:load_scheduler/models/sensors/tank_level.dart';
import 'package:load_scheduler/models/sensors/temp_inside.dart';
import 'package:load_scheduler/models/sensors/temp_outside.dart';
import 'package:load_scheduler/models/sensors/weather.dart';

class SensorsService {
  static List<Sensor> sensors = [];

  static initSensors() {
    sensors.clear();
    sensors.add(BatteryLevel('Battery Level', Icons.battery_charging_full));
    sensors.add(TankLevel('Tank Level', Icons.water));
    sensors.add(Clock('Clock', Icons.access_time));
    sensors.add(Weather('Weather', Icons.wb_sunny));
    sensors.add(TempInside('Temperature Inside', Icons.thermostat_outlined));
    sensors.add(TempOutside('Temperature Outside', Icons.ac_unit));
  }
}