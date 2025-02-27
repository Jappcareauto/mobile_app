import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/features/vehicleFinder/ui/vehicleFinder/widgets/located_container_widget.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/widgets/map_widget.dart';
import 'controllers/vehicle_finder_controller.dart';
import 'package:get/get.dart';

class VehicleFinderScreen extends GetView<VehicleFinderController> {
  const VehicleFinderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body:  Stack(
        children: [
          const MapWiget(),
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
                              padding: const EdgeInsets.all(12),
                              child: const Icon(FluentIcons.arrow_left_12_regular, size: 24,),
                            )
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFF8F6),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: const LocatedContainerWidget(haveButton: true,)
                  )
                ],
              )
          )
        ],
      )
    );
  }
}
