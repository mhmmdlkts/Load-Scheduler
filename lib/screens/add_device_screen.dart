import 'package:flutter/material.dart';
import 'package:load_scheduler/models/devices/air_condition.dart';
import 'package:load_scheduler/models/devices/devices.dart';
import 'package:load_scheduler/models/devices/heat_pump.dart';
import 'package:load_scheduler/models/devices/hether.dart';
import 'package:load_scheduler/models/devices/pump.dart';
import 'package:load_scheduler/models/sensors/sensor.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({Key key}) : super(key: key);

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {

  List<Device> _deviceList = [];

  @override
  void initState() {
    super.initState();
    initList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new device'),
      ),
      body: ListView.separated(
        itemCount: _deviceList.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.pop(context, _deviceList[index]);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Text(_deviceList[index].name),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1,height: 1,),
      ),
    );
  }

  void initList() {
    setState(() {
      _deviceList.clear();
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
      _deviceList.add(heater);
      _deviceList.add(pump);
      _deviceList.add(airCondition);
      _deviceList.add(heatPump);
    });
  }
}
