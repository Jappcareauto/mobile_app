import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import 'package:jappcare/features/shop/ui/shop/widgets/tabs_list_widgets.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_services.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/ui/workshop/controllers/workshop_controller.dart';
import 'service_widget.dart';

class ServiceCenterServicesListWidget extends GetView<WorkshopController> {
  final globalControllerWorkshop = Get.find<GlobalcontrollerWorkshop>();
  final List<ServiceEntity> services;
  final Function(ServiceEntity)? onSelect;
  final bool? canSelect;

  ServiceCenterServicesListWidget(
      {super.key,
      required this.services,
      this.onSelect,
      this.canSelect = false});

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
          child: services.isNotEmpty
              ? ServiceWidget(
                  tabs: services.map((service) => service.title).toList(),
                  selectedFilter: controller.selectedService,
                  data: services,
                  onSelected: (data) {
                    onSelect?.call(data);
                    print(
                        "L'IDENTIFIANT DU SERVICE SELECTIONNER EST : ${data.id}");
                    controller.servicesId.value = data.id;
                    globalControllerWorkshop.addData('serviceId', data.id);
                  },
                  selectedTabs: controller.selectedCategory,
                  borderRadius: BorderRadius.circular(16),
                  haveBorder: true,
                )
              : const Text('Aucun service disponible'),
        ),
      ],
    );
  }
}
