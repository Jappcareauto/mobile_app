import 'package:flutter/material.dart';
import 'controllers/payments_controller.dart';
import 'package:get/get.dart';

class PaymentsScreen extends GetView<PaymentsController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text('Payments Screen'),
      ),
      body:  Center(
        child: Text('Welcome to Payments Screen'),
      ),
    );
  }
}
