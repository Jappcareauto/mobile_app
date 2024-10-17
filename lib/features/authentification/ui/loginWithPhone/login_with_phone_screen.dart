import 'package:flutter/material.dart';
import 'controllers/login_with_phone_controller.dart';
import 'package:get/get.dart';

class LoginWithPhoneScreen extends GetView<LoginWithPhoneController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text('LoginWithPhone Screen'),
      ),
      body:  Center(
        child: Text('Welcome to LoginWithPhone Screen'),
      ),
    );
  }
}
