import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:load_scheduler/models/sensors/sensor.dart';

class Weather extends Sensor {
  Weather(String name, IconData icon) : super(name, icon);

  @override
  String getDefaultValue() {
    List<String> weathers = ['Rainy', 'Snowy', 'Sunny', 'Cloudy', 'Stormy'];
    final _random = Random();
    return weathers[_random.nextInt(weathers.length)];
  }

  @override
  String getDefaultUnit() {
    return '';
  }

}