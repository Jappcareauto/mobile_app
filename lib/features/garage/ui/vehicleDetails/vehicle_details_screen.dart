import 'package:flutter/material.dart';
import 'controllers/vehicle_details_controller.dart';
import 'package:get/get.dart';

class VehicleDetailsScreen extends GetView<VehicleDetailsController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text('VehicleDetails Screen'),
      ),
      body:  Center(
        child: Text('Welcome to VehicleDetails Screen'),
      ),
    );
  }
}
