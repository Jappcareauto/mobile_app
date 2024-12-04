

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/ui/autoshop_detail/controllers/autoshop_controller.dart';

class BannerWidget extends GetView<AutoShopController> {


  @override
  Widget build(BuildContext context) {
   return Stack(
      children: [

              ImageComponent(
                assetPath: AppImages.shopCar,
              ),




        Positioned(
          top: MediaQuery.of(context).padding.top+20,
          left: 30,
          child:
              GestureDetector(
                onTap:(){
                  Get.back();
                },
                  child:
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(right: 5),
                    child:
                    Icon(
                      FluentIcons.arrow_left_24_regular,
                      color: Colors.black,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Get.theme.scaffoldBackgroundColor),
                  )
    )
       ,)
      ],
    );
  }
}