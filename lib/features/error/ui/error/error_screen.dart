import 'package:flutter/material.dart';
import 'controllers/error_controller.dart';
import 'package:get/get.dart';

class ErrorScreen extends GetView<ErrorController> {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Error Screen'),
      ),
      body:  const Center(
        child: Text('Welcome to Error Screen'),
      ),
    );
  }
}
