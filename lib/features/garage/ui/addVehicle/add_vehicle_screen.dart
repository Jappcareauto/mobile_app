import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/features/workshop/ui/chat/widgets/payment_method_widget.dart';
import 'controllers/add_vehicle_controller.dart';
import 'package:get/get.dart';

class AddVehicleScreen extends GetView<AddVehicleController> {
  const AddVehicleScreen({super.key});
  final int maxVinLength = 17;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Add Vehicle",
          appBarcolor: Get.theme.scaffoldBackgroundColor,
        ),
        body: MixinBuilder<AddVehicleController>(
          init: AddVehicleController(Get.find()),
          initState: (_) {},
          builder: (controller) {
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: controller.addVehicleFormHelper.formKey,
                          autovalidateMode: controller
                              .addVehicleFormHelper.autovalidateMode.value,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              CustomFormField(
                                controller: controller
                                    .addVehicleFormHelper.controllers['vin'],
                                label: "VIN/Chassi Number",
                                hintText: "Ex. 2GTEC13TX51385216",
                                forceUpperCase: true,
                                validator: controller
                                    .addVehicleFormHelper.validators['vin'],
                                maxLength: maxVinLength,
                              ),

                              const SizedBox(height: 20),
                              // Character count text
                              Obx(() => Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "${controller.vinCharacterCount}/$maxVinLength characters",
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  )),
                              const SizedBox(height: 20),
                              CustomFormField(
                                controller: controller.addVehicleFormHelper
                                    .controllers['registration'],
                                label: "License Plate Number",
                                hintText: "Ex. NW 905 AG",
                                forceUpperCase: true,
                                validator: controller.addVehicleFormHelper
                                    .validators['registration'],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomButton(
                      text: "Add Vehicle",
                      onPressed: () => {
                        controller.addVehicleFormHelper.submit()
                        // onpenModalPaymentMethod(
                        //     ),
                      },
                      isLoading: controller.addVehicleFormHelper.isLoading,
                    ),
                  ),
                ],
              ),
            );
          },
        ));
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
                color: Colors.black.withValues(alpha: .1),
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
