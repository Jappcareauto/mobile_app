import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/shimmers/list_vehicle_shimmer.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import 'controllers/workshop_controller.dart';
import 'package:get/get.dart';

import 'widgets/categories_item_list.dart';
import 'widgets/service_item.dart';

class WorkshopScreen extends GetView<WorkshopController>
    implements FeatureWidgetInterface {
  const WorkshopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WorkshopController(Get.find(), ));
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Workshop",
          canBack: false,
        ),
        body: SingleChildScrollView(
            child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: CustomFormField(
                            hintText: "Search Centers",
                            prefix: Icon(FluentIcons.search_24_regular),
                          ),
                        ),
                      ),

                      //  SizedBox(width: 5),
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(right: 5),
                        child: ImageComponent(
                          assetPath: AppImages.mapsquare,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Get.theme.primaryColor.withOpacity(.1)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        padding: EdgeInsets.all(5),
                        child: Icon(FluentIcons.options_16_regular),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Get.theme.primaryColor.withOpacity(.1)),
                      ),
                      SizedBox(width: 20),
                      Container(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Around Me',
                          style: Get.textTheme.bodyMedium
                              ?.copyWith(
                              color: Get.theme.scaffoldBackgroundColor),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Get.theme.primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SelectServiceItemList(
                    title: 'Select Service',
                  ),
                  SizedBox(height: 20),
                  Obx((){
                    return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child:
                    Column(
                      children: controller.loading.value
                          ? [ // Encapsuler ListVehicleShimmer dans un conteneur de hauteur définie
                        SizedBox(
                          height: 190, // Hauteur fixée
                          child: ListVehicleShimmer(),
                        ),
                      ]
                          : (controller.servicesCenter.value?.data != null &&
                          controller.servicesCenter.value!.data.isNotEmpty)
                          ? controller.servicesCenter.value!.data.map<Widget>((service) {
                        return GestureDetector(
                          onTap: () {
                            controller.goToWorkshopDetails(
                              service.name ?? 'Inconnu',
                              service.location?.description ?? 'Inconnu',
                              service.location?.latitude ?? 0.0,
                              service.location?.longitude ?? 0.0,
                            );
                          },
                          child: ServiceItemWidget(
                            image: AppImages.shopCar,
                            title: service.name ?? 'Inconnu',
                            rate: '4.5',
                            location: 'Douala, Cameroun',
                          ),
                        );
                      }).toList()
                          : [
                        Text(
                          'Aucun service disponible',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )

                  );
  })
                ]
            )
        )
    );
  }

  @override
  Widget buildView([args]) {
    return this;
  }
}
