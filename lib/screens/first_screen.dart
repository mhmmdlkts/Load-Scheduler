import 'package:flutter/material.dart';
import 'package:load_scheduler/enums/working_mode_enum.dart';
import 'package:load_scheduler/models/devices/devices.dart';
import 'package:load_scheduler/models/sensors/sensor.dart';
import 'package:load_scheduler/screens/add_device_screen.dart';
import 'package:load_scheduler/screens/configure_device_screen.dart';
import 'package:load_scheduler/screens/configure_sensor_screen.dart';
import 'package:load_scheduler/services/devices_service.dart';
import 'package:load_scheduler/services/sensors_service.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  @override
  void initState() {
    super.initState();
    SensorsService.initSensors();
    DevicesService.initDevices();

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Load Scheduler'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'Devices'),
              Tab(text: 'Sensors'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _homeContent(),
            _devicesContent(),
            _sensorContent(),
          ],
        ),
      ),
    );

  }

  Widget _sensorContent() {
    return Container(
      child: ListView.separated(
        itemCount: SensorsService.sensors.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () async {
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(SensorsService.sensors[index].name),
                Row(
                  children: [
                    Text(SensorsService.sensors[index].getDefaultValue()),
                    Container(width: 10,),
                    Icon(SensorsService.sensors[index].icon)
                  ],
                )
              ],
            ),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1,height: 1,),
      ),
    );
  }

  Widget _homeContent() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Container(height: 20,),
            const Text('Current consumption', style: TextStyle(fontSize: 26),),
            Text(DevicesService.getTotalUsage().toStringAsFixed(2) + ' kW', style: const TextStyle(fontSize: 24, color: Colors.blue),),
            Container(height: 20,),
            Visibility(
              visible: DevicesService.myDevices.isEmpty, // Air condition., Heat pump,
              child: _addNewDeviceButton(),
            ),
            Container(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: DevicesService.myDevices.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () async {
                    print(index);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConfigureDeviceScreen(device: DevicesService.myDevices[index])),
                    );
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DevicesService.myDevices[index].name),
                        Row(
                          children: [
                            Text(DevicesService.myDevices[index].getUsage().toStringAsFixed(2) + ' kW'),
                            Container(width: 10,),
                            Device.getWorkingIcon(DevicesService.myDevices[index].workingMode)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1,height: 1,),
              ),
            ),
          ],
        ),
        Positioned(
          right: 25,
          bottom: 25,
          child: FloatingActionButton(
            onPressed: _addNewDevice,
            child: const Icon(Icons.add),
          ),
        )
      ],
    );
  }

  Widget _devicesContent() {
    return Container(
      child: ListView.separated(
        itemCount: DevicesService.allDevices.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () async {
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DevicesService.allDevices[index].name),
                Icon(DevicesService.allDevices[index].icon)
              ],
            ),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1,height: 1,),
      ),
    );
  }

  void _addNewDevice() async {
    final Device result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddDeviceScreen()),
    );
    if (result != null) {
      setState(() {
        DevicesService.myDevices.add(result);
      });
    }
  }

  Widget _addNewDeviceButton() =>  Container (
    padding: const EdgeInsets.all(20),
    width: MediaQuery.of(context).size.width,
    child: ElevatedButton(
      onPressed: _addNewDevice,
      child: const Text('Add new device')
    )
  );

}
