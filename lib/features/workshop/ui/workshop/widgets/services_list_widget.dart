import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/shop/ui/shop/widgets/tabs_list_widgets.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/ui/workshop/controllers/workshop_controller.dart';

class ServicesListWidget extends GetView<WorkshopController> {
  final globalControllerWorkshop = Get.find<GlobalcontrollerWorkshop>();

  ServicesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Obx(() {
        return controller.serviceloading.value
            ? const Text('loading')
            : (controller.services.value?.data != null &&
                    controller.services.value!.data.isNotEmpty)
                ? TabsListWidgets(
                    tabs: controller.services.value!.data
                        .map((service) => service.title)
                        .toList(),
                    selectedFilter: controller.selectedFilter,
                    data: controller.services.value!.data,
                    onSelected: (data) {
                      print(
                          "L'IDENTIFIANT DU SERVICE SELECTIONNER EST : ${data.id}");
                      controller.servicesId.value = data.id;
                      globalControllerWorkshop.addData('servciceId', data.id);
                    },
                    selectedTabs: controller.selectedCategory,
                    borderRadius: BorderRadius.circular(16),
                    haveBorder: true,
                  )
                : const Text('Aucun service disponible');
      }),
    );
  }
}
