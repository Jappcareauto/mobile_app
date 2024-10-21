import 'package:flutter/material.dart';
import 'controllers/profile_controller.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text('Profile Screen'),
      ),
      body:  Center(
        child: Text('Welcome to Profile Screen'),
      ),
    );
  }
}
