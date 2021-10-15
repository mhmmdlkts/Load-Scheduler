import 'package:flutter/material.dart';
import 'package:load_scheduler/enums/working_mode_enum.dart';
import 'package:load_scheduler/models/devices/devices.dart';
import 'package:load_scheduler/models/sensors/sensor.dart';

class ConfigureSensorScreen extends StatefulWidget {
  final Sensor sensor;
  const ConfigureSensorScreen({Key key, this.sensor}) : super(key: key);

  @override
  State<ConfigureSensorScreen> createState() => _ConfigureSensorScreenState();
}

class _ConfigureSensorScreenState extends State<ConfigureSensorScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sensor.name),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              children: [
              ],
            ),
          ],
        )
      )
    );
  }

  Icon iconBuilder(WorkingModeEnum mode, Size size, bool active) {
    return Device.getIcon(mode);
  }
}
