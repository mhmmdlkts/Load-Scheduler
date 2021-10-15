import 'package:load_scheduler/models/devices/air_condition.dart';
import 'package:load_scheduler/models/devices/devices.dart';
import 'package:load_scheduler/models/devices/heat_pump.dart';
import 'package:load_scheduler/models/devices/hether.dart';
import 'package:load_scheduler/models/devices/pump.dart';

class DevicesService {
  static List<Device> allDevices = [];
  static List<Device> myDevices = [];

  static double getTotalUsage() {
    double sum = getRestUsage();
    for (Device device in myDevices) {
      sum += device.getUsage();
    }
    return sum;
  }

  static double getRestUsage() {
    return 0.2; // other devices TODO
  }

  static initDevices() {
    allDevices.clear();
    Heater heater = Heater('Heater');
    Pump pump = Pump('Pump');
    AirCondition airCondition = AirCondition('Air Condition');
    HeatPump heatPump = HeatPump('Heat Pump');
    heater.workingLevels = [1.3, 1.5, 1.8, 2.1];
    pump.workingLevels = [1.2];
    airCondition.workingLevels = [0.7];
    heatPump.workingLevels = [0.6];
    heater.level = 2;
    pump.level = 0;
    airCondition.level = 0;
    heatPump.level = 0;
    allDevices.add(heater);
    allDevices.add(pump);
    allDevices.add(airCondition);
    allDevices.add(heatPump);
  }
}