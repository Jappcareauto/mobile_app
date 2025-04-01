import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/services_list_widget.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/workshop_shimmer_widgets.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import 'controllers/workshop_controller.dart';
import 'package:get/get.dart';

import 'widgets/service_item.dart';

class WorkshopScreen extends GetView<WorkshopController>
    implements FeatureWidgetInterface {
  const WorkshopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarcolor: Get.theme.scaffoldBackgroundColor,
        title: "Service Centers",
        canBack: true,
        actions: [
          if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
            Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
        ],
      ),
      body: MixinBuilder<WorkshopController>(
        init: WorkshopController(Get.find()),
        initState: (_) {},
        builder: (controller) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Form(
                            key: controller.getServiceCentersFormHelper.formKey,
                            autovalidateMode: controller
                                .getServiceCentersFormHelper
                                .autovalidateMode
                                .value,
                            child: CustomFormField(
                              controller: controller.getServiceCentersFormHelper
                                  .controllers['name'],
                              borderRadius: 32,
                              filColor: AppColors.white,
                              hintText: "Search Centers",
                              prefix: const Icon(FluentIcons.search_24_regular),
                              validator: controller.getServiceCentersFormHelper
                                  .validators['name'],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.white),
                          child: const Icon(FluentIcons.options_16_regular),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Get.theme.primaryColor),
                          child: Text(
                            'Around Me',
                            style: Get.textTheme.bodyMedium?.copyWith(
                                color: Get.theme.scaffoldBackgroundColor),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Get.theme.primaryColor),
                          child: Text(
                            'Available Now',
                            style: Get.textTheme.bodyMedium?.copyWith(
                                color: Get.theme.scaffoldBackgroundColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ServicesListWidget(),
                  const SizedBox(height: 8),
                  Obx(
                    () {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: controller.loading.value
                              ? [
                                  // Encapsuler ListVehicleShimmer dans un conteneur de hauteur définie
                                  const SizedBox(
                                      height: 190, // Hauteur fixée
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            WorkshopShimmerWidgets(),
                                            WorkshopShimmerWidgets(),
                                          ],
                                        ),
                                      )),
                                ]
                              : (controller.servicesCenter.value?.data !=
                                          null &&
                                      controller.servicesCenter.value!.data
                                          .isNotEmpty)
                                  ? controller.servicesCenter.value!.data
                                      .map<Widget>((service) {
                                      return GestureDetector(
                                        onTap: () {
                                          controller.goToWorkshopDetails(
                                              name: service.name ?? 'Inconnu',
                                              description: service
                                                      .location?.description ??
                                                  'Inconnu',
                                              latitude:
                                                  service.location?.latitude ??
                                                      0.0,
                                              longitude:
                                                  service.location?.longitude ??
                                                      0.0,
                                              id: service.id,
                                              availability:
                                                  service.availability,
                                              locationName:
                                                  service.location?.name);
                                        },
                                        child: ServiceItemWidget(
                                          image: AppImages.shopCar,
                                          title: service.name ?? 'Inconnu',
                                          rate: '4.5',
                                          location: service.location?.name ??
                                              'Douala, Cameroun',
                                        ),
                                      );
                                    }).toList()
                                  : [
                                      const Text(
                                        'Aucun service disponible',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildView([args]) {
    return this;
  }

  @override
  void refreshData() {
    // TODO: implement refreshData
  }
}
