import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/features/chat/ui/chat/widgets/payment_method_widget.dart';
import 'package:jappcare/features/services/ui/generateVehiculeReport/controllers/generate_vehicule_report_controller.dart';
import 'package:jappcare/features/services/ui/oderDetail/widgets/resume_services_widget.dart';
import 'controllers/order_detail_controller.dart';
import 'package:get/get.dart';

class OrderDetailScreen extends GetView<OrderDetailController> {
  final GenerateVehiculeReportController generateVehicleReportController =
      Get.put(GenerateVehiculeReportController(Get.find()));

  OrderDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Order Details'),
      body: Column(
        children: [
          if (Get.isRegistered<FeatureWidgetInterface>(
              tag: 'ListVehicleWidget'))
            Get.find<FeatureWidgetInterface>(tag: 'ListVehicleWidget')
                .buildView({
              "pageController": generateVehicleReportController.pageController,
              "currentPage": generateVehicleReportController.currentPage,
              "haveAddVehicule": false,
              "isSingleCard": true,
              "title": "My Garage",
              "onSelected": (index) {
                print('seleccar');
                print(index);
              },
              "onTapeAddVehicle": () {
                print("clique");
              },
            }),
          const ResumeServicesWidget(),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10),
            child: CustomButton(
              text: 'Poceed',
              onPressed: () {
                onpenModalPaymentMethod(controller.goToVehiculeReport);
              },
            ),
          )
        ],
      ),
    );
  }
}

void onpenModalPaymentMethod(VoidCallback onConfirm) {
  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true, // Permet un contrôle précis sur la hauteur
    backgroundColor: Colors.transparent, // Rendre l'arrière-plan transparent
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16), // Espacement intérieur
          child: Wrap(
            children: [
              PaymentMethodeWidget(onConfirm: onConfirm),
            ],
          ),
        ),
      );
    },
  );
}
