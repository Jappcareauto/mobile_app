import 'package:flutter/material.dart';
import 'controllers/garage_controller.dart';
import 'package:get/get.dart';

class GarageScreen extends GetView<GarageController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text('Garage Screen'),
      ),
      body:  Center(
        child: Text('Welcome to Garage Screen'),
      ),
    );
  }
}
