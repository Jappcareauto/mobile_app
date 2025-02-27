 import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/controllers/services_locator_controller.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/widgets/map_widget.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/widgets/services.dart';

class ServicesCenterLocator extends GetView<ServicesLocatorController>{
  const ServicesCenterLocator({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(

          children: [
              const MapWiget(),
              Column(

                children: [
                  const SizedBox(height: 100,),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomFormField(
                            filColor: Get.theme.scaffoldBackgroundColor,
                            hintText: "Search Centers",
                            prefix: const Icon(FluentIcons.search_24_regular),
                          ),
                        ),
                      ),

                      //  SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Get.theme.scaffoldBackgroundColor),
                        child: IconButton(
                          onPressed: (){
                            Get.back();
                          },
                       icon: const Icon(
                          FluentIcons.arrow_left_24_regular,
                          color: Colors.black,
                        ),
    ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Get.theme.scaffoldBackgroundColor),
                        child: const Icon(FluentIcons.options_16_regular),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Get.theme.primaryColor),
                        child: Text(
                          'Around Me',
                          style: Get.textTheme.bodyMedium
                              ?.copyWith(color: Get.theme.scaffoldBackgroundColor),
                        ),
                      ),
                      const SizedBox(width: 20) ,
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Get.theme.primaryColor),
                        child: Text(
                          'Under 5k',
                          style: Get.textTheme.bodyMedium
                              ?.copyWith(color: Get.theme.scaffoldBackgroundColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            Positioned(
              bottom: 0, // Place le bottom sheet en bas de l'écran
              left: 0,
              right: 0,
              child: Obx(
                    () => GestureDetector(
                  onTap: () {
                    print('Toggle bottom sheet size');
                    controller.toggleExpansion(); // Alterne l'état du bottom sheet
                  },
                  onVerticalDragEnd: (details) {
                    if (details.primaryVelocity! >
                        0) { // Swipe vers le bas
                      controller.toggleExpansion();
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: controller.bottomSheetHeight.value, // Hauteur dynamique
                    decoration: BoxDecoration(
                      color: Get.theme.scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Un indicateur de "drag"
                        Container(
                          width: 40,
                          height: 5,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        const SizedBox(height: 10),

                        Expanded(
                          child: Obx(
                                () => ServiceWidget(
                                  onTap: (){
                                    controller.gottoautoshopDetail() ;
                                  },
                              ishide: controller.isExpanded.value , // Gère l'affichage des `Row`
                              image: AppImages.shopCar,
                              title: 'Japtech Auto Shop',
                              rate: '4.5',
                              location: 'Yaoundé, Cameroun',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],

        )
        );

  }

}