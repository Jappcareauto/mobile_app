import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_colors.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget(
      {required this.bodyText,
      super.key,
      required this.coloriage,
        this.textSize,
        this.haveTitle,
      required this.icon,
        required this.backgrounColor,
      required this.title, this.onTap});
  final IconData icon;
  final Color coloriage;
  final Color? backgrounColor ;
  final String bodyText;
  final double? textSize ;
  final bool? haveTitle;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgrounColor  ,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.lightBorder)),
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 20, right: 20),
          title:  haveTitle == true ?
          Row(
            children: [

              Icon(icon, size: 24, color: coloriage) ,

              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                    fontSize:16, fontWeight: FontWeight.bold, color: coloriage),
              ),

            ],
          ) :
              SizedBox(),
          subtitle: Text(
            bodyText,
            style: TextStyle(fontSize:  textSize != null ? textSize : 16),
          ),
          trailing: CircleAvatar(
              backgroundColor: coloriage.withOpacity(.1),
              radius: 35,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  backgroundColor: coloriage,
                  radius: 25,
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

/* 'Your repair from the Japcare Autotech shop is ready, and available for pickup'*/ 