import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          boxShadow:[
            BoxShadow(
                blurRadius: 25,
                blurStyle: BlurStyle.normal,
                color: Colors.black,
                offset: Offset.zero,
                spreadRadius: 2
            ),
          ] ,
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Icon(FluentIcons.chat_16_filled , color: Get.theme.scaffoldBackgroundColor,size: 30,),
    );
  }

}
