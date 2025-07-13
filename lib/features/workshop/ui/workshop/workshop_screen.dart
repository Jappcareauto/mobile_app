import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/service_widget.dart';
// import 'package:jappcare/features/workshop/ui/workshop/widgets/services_list_widget.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/workshop_shimmer_widgets.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import 'controllers/workshop_controller.dart';
import 'package:get/get.dart';
// import '../workshop/widgets/services_list_widget.dart';

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
        canBack: false,
        // actions: [
        //   if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
        //     Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
        // ],
      ),
      body: MixinBuilder<WorkshopController>(
        init: WorkshopController(Get.find()),
        initState: (_) {},
        builder: (controller) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Row(
                    spacing: 10,
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
                            validator: controller
                                .getServiceCentersFormHelper.validators['name'],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => controller.showFiltersDialog(),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.white),
                          child: const Icon(FluentIcons.options_16_regular),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "Specialized Services",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    child: controller.services.value != null &&
                            controller.services.value!.data.isNotEmpty
                        ? Obx(() {
                            final services = controller.services.value!.data;
                            return ServiceWidget(
                              tabs: services,
                              selectedFilter: controller.selectedService.value,
                              onSelected: (index) {
                                if (controller.selectedService.value == index) {
                                  controller.selectedService.value = -1;
                                  controller.selectedCategory.value = '';
                                } else {
                                  controller.selectedCategory.value =
                                      services[index].title;
                                  controller.selectedService.value = index;
                                }
                              },
                              borderRadius: BorderRadius.circular(16),
                              haveBorder: true,
                            );
                          })
                        : const Text('Aucun service disponible'),
                  ),
                  Obx(
                    () {
                      return Column(
                        children: controller.loading.value
                            ? [
                                // Encapsuler ListVehicleShimmer dans un conteneur de hauteur définie
                                Column(
                                  children: [
                                    WorkshopShimmerWidgets(),
                                  ],
                                ),
                              ]
                            : (controller.servicesCenter.value?.data != null &&
                                    controller
                                        .servicesCenter.value!.data.isNotEmpty)
                                ? controller.servicesCenter.value!.data
                                    .map<Widget>((serviceCenter) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.goToWorkshopDetails(
                                            name:
                                                serviceCenter.name ?? 'Inconnu',
                                            centerServices:
                                                serviceCenter.services,
                                            description: serviceCenter
                                                    .location?.description ??
                                                'Inconnu',
                                            latitude: serviceCenter
                                                    .location?.latitude ??
                                                0.0,
                                            longitude: serviceCenter
                                                    .location?.longitude ??
                                                0.0,
                                            id: serviceCenter.id,
                                            availability:
                                                serviceCenter.available ??
                                                    false,
                                            locationName:
                                                serviceCenter.location?.name);
                                      },
                                      child: ServiceItemWidget(
                                        image: serviceCenter.imageUrl ??
                                            AppImages.shopCar,
                                        title: serviceCenter.name ?? 'Inconnu',
                                        rate: '4.5',
                                        location:
                                            serviceCenter.location?.name ??
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
