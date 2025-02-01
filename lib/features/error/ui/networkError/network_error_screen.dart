import 'package:flutter/material.dart';
import 'controllers/network_error_controller.dart';
import 'package:get/get.dart';

class NetworkErrorScreen extends GetView<NetworkErrorController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text('NetworkError Screen'),
      ),
      body:  Center(
        child: Text('Welcome to NetworkError Screen'),
      ),
    );
  }
}
