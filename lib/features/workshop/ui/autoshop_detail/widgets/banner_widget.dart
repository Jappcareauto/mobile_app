

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/ui/autoshop_detail/controllers/autoshop_controller.dart';

class BannerWidget extends GetView<AutoShopController> {
  final Icon leftIcon ;
  final IconButton? RightIcon ;
  final Widget imageComponents ;

  BannerWidget({
    Key? key,
    required this.imageComponents,
    required this.leftIcon,
     this.RightIcon
}): super(key: key);

  @override
  Widget build(BuildContext context) {
   return Stack(
      children: [
        imageComponents,
        Positioned(
          top: MediaQuery.of(context).padding.top+20,
          left: 30,
          child:
              GestureDetector(
                onTap: (){
                  Get.back() ;
                },
                child:  Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(right: 5),
                  child: leftIcon,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Get.theme.scaffoldBackgroundColor),
                ),
              )
       ),

        Positioned(
          top: MediaQuery.of(context).padding.top+20,
          right: 30,
          child:
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(right: 5),
            child: RightIcon,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Get.theme.scaffoldBackgroundColor),
          ),)
      ],
    );
  }
}