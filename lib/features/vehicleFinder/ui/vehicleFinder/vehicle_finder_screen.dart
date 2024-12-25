import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/vehicleFinder/ui/vehicleFinder/widgets/located_container_widget.dart';
import 'package:jappcare/features/vehicleFinder/ui/vehicleFinder/widgets/search_vehicle_widget.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/widgets/map_widget.dart';
import 'controllers/vehicle_finder_controller.dart';
import 'package:get/get.dart';

class VehicleFinderScreen extends GetView<VehicleFinderController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body:  Stack(
        children: [
          MapWiget(),
          Positioned(
            bottom: 20,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child:  GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(32)
                              ),
                              padding: EdgeInsets.all(12),
                              child: Icon(FluentIcons.arrow_left_12_regular, size: 24,),
                            )
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xFFFFF8F6),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: LocatedContainerWidget(haveButton: true,)
                  )
                ],
              )
          )
        ],
      )
    );
  }
}
