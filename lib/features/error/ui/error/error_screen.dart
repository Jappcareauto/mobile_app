import 'package:flutter/material.dart';
import 'controllers/error_controller.dart';
import 'package:get/get.dart';

class ErrorScreen extends GetView<ErrorController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text('Error Screen'),
      ),
      body:  Center(
        child: Text('Welcome to Error Screen'),
      ),
    );
  }
}
