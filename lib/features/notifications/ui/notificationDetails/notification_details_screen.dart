import 'package:flutter/material.dart';
import 'controllers/notification_details_controller.dart';
import 'package:get/get.dart';

class NotificationDetailsScreen extends GetView<NotificationDetailsController> {
  const NotificationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  const Text('NotificationDetails Screen'),
      ),
      body:  const Center(
        child: Text('Welcome to NotificationDetails Screen'),
      ),
    );
  }
}
