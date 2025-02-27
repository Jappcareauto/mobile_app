

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/autoshop_detail/controllers/autoshop_controller.dart';

class BannerWidget extends GetView<AutoShopController> {
  final Icon leftIcon ;
  final IconButton? RightIcon ;
  final Widget imageComponents ;

  const BannerWidget({
    super.key,
    required this.imageComponents,
    required this.leftIcon,
     this.RightIcon
});

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
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Get.theme.scaffoldBackgroundColor),
                  child: leftIcon,
                ),
              )
       ),

        Positioned(
          top: MediaQuery.of(context).padding.top+20,
          right: 30,
          child:
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Get.theme.scaffoldBackgroundColor),
            child: RightIcon,
          ),)
      ],
    );
  }
}