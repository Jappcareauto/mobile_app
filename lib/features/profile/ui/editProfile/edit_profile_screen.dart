import 'package:flutter/material.dart';
import 'controllers/edit_profile_controller.dart';
import 'package:get/get.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text('EditProfile Screen'),
      ),
      body:  Center(
        child: Text('Welcome to EditProfile Screen'),
      ),
    );
  }
}
