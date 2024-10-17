import 'package:flutter/material.dart';
import 'controllers/add_vehicle_controller.dart';
import 'package:get/get.dart';

class AddVehicleScreen extends GetView<AddVehicleController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text('AddVehicle Screen'),
      ),
      body:  Center(
        child: Text('Welcome to AddVehicle Screen'),
      ),
    );
  }
}
