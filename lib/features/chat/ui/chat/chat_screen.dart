import 'package:flutter/material.dart';
import 'controllers/chat_controller.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text('Chat Screen'),
      ),
      body: const Center(
        child: Text('Welcome to Chat Screen'),
      ),
    );
  }
}
 