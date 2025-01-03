import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: controller.servicesCenter?.data != null
                          ? controller.servicesCenter!.data.map<Widget>((service) {
                        return GestureDetector(
                          onTap: () {
                            controller.gotToServicesLocator();
                          },
                          child: ServiceItemWidget(
                            image: AppImages.shopCar,
                            title: service.name,
                            rate: '4.5',
                            location: 'Douala, Cameroun',
                          ),
                        );
                      }).toList()
                          : [
                            Text('Aucun service disponible')
                      ], // Si `data` est null
                    )

                  )
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
