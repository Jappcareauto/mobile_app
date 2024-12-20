import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'controllers/services_controller.dart';
import 'package:get/get.dart';

class ServicesScreen extends GetView<ServicesController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppBar(title: 'Services'),
      body:  Center(
        child: GestureDetector(
          onTap: (){
            controller.goToGenerateVehiculeReport();
          },
          child: Text('Welcome to Services Screen'),
        ),
      ),
    );
  }
}
