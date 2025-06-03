import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/features/chat/ui/chat/widgets/payment_method_widget.dart';
import 'controllers/add_vehicle_controller.dart';
import 'package:get/get.dart';

class AddVehicleScreen extends GetView<AddVehicleController> {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Add Vehicle'),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const CustomFormField(
                label: 'VIN/Chassis Number',
                hintText: 'e.g 3GCUKREC8EG359263',
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomFormField(
                label: 'License Plate Number',
                hintText: 'Ex. NW 905 AG',
              ),
              const Spacer(),
              CustomButton(
                  text: 'Add Vehicle',
                  onPressed: () {
                    onpenModalPaymentMethod(controller.goBack);
                  })
            ],
          ),
        ));
  }
}

void onpenModalPaymentMethod(void onConfirm) {
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
              PaymentMethodeWidget(onConfirm: () {
                onConfirm;
              }),
            ],
          ),
        ),
      );
    },
  );
}
