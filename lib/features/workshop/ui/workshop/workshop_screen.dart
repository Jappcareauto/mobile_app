import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/utils/app_images.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import 'controllers/workshop_controller.dart';
import 'package:get/get.dart';

import 'widgets/categories_item_list.dart';
import 'widgets/service_item.dart';

class WorkshopScreen extends GetView<WorkshopController>
    implements FeatureWidgetInterface {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Workshop"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomFormField(
                  hintText: "Search Centers",
                  prefix: Icon(FluentIcons.search_24_regular),
                ),
              ),
              const SizedBox(height: 20),
              SelectServiceItemList(
                title: 'Select Service',
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  ServiceItemWidget(
                    image: AppImages.shopCar,
                    title: 'Japtech Auto Shop',
                    rate: '4.5',
                    location: 'Douala, Cameroun',
                  ),
                  ServiceItemWidget(
                    image: AppImages.maintenanceCar,
                    title: 'Japtech Auto Shop',
                    rate: '4.5',
                    location: 'Yaoundé, Cameroun',
                  )
                ]),
              )
            ],
          ),
        ));
  }

  @override
  Widget buildView([args]) {
    return this;
  }
}
