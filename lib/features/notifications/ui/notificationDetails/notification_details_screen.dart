import 'package:flutter/material.dart';
import 'controllers/notification_details_controller.dart';
import 'package:get/get.dart';

class NotificationDetailsScreen extends GetView<NotificationDetailsController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text('NotificationDetails Screen'),
      ),
      body:  Center(
        child: Text('Welcome to NotificationDetails Screen'),
      ),
    );
  }
}
