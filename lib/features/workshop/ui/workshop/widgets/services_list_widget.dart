import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/shop/ui/shop/widgets/tabs_list_widgets.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/ui/workshop/controllers/workshop_controller.dart';

class ServicesListWidget extends GetView<WorkshopController> {
  final globalControllerWorkshop = Get.find<GlobalcontrollerWorkshop>();
  final bool? canSelect;

  ServicesListWidget({super.key, this.canSelect = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Specialized Services",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          child: Obx(
            () {
              return controller.serviceloading.value
                  ? const Text('loading')
                  : (controller.services.value?.data != null &&
                          controller.services.value!.data.isNotEmpty)
                      ? TabsListWidgets(
                          tabs: controller.services.value!.data
                              .map((service) => service.title)
                              .toList(),
                          selectedFilter: controller.selectedService,
                          data: controller.services.value!.data,
                          onSelected: (data) {
                            print(controller.services.value?.data[0]);
                            print("Selected service ID: ${data.id}");
                            controller.servicesId.value = data.id;
                            globalControllerWorkshop.addData(
                                'serviceId', data.id);
                          },
                          selectedTabs: controller.selectedCategory,
                          borderRadius: BorderRadius.circular(16),
                          haveBorder: true,
                        )
                      : const Text('No services available');
            },
          ),
        ),
      ],
    );
  }
}
