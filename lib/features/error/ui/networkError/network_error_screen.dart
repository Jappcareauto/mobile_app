import 'package:flutter/material.dart';
import 'controllers/network_error_controller.dart';
import 'package:get/get.dart';

class NetworkErrorScreen extends GetView<NetworkErrorController> {
  const NetworkErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  const Text('NetworkError Screen'),
      ),
      body:  const Center(
        child: Text('Welcome to NetworkError Screen'),
      ),
    );
  }
}
