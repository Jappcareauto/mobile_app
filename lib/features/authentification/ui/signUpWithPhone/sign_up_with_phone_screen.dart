import 'package:flutter/material.dart';
import 'controllers/sign_up_with_phone_controller.dart';
import 'package:get/get.dart';

class SignUpWithPhoneScreen extends GetView<SignUpWithPhoneController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text('SignUpWithPhone Screen'),
      ),
      body:  Center(
        child: Text('Welcome to SignUpWithPhone Screen'),
      ),
    );
  }
}
