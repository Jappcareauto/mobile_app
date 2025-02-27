import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/features/workshop/ui/chat/widgets/payment_method_widget.dart';
import 'controllers/add_vehicle_controller.dart';
import 'package:get/get.dart';

class AddVehicleScreen extends GetView<AddVehicleController> {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Add Vehicle"),
        body: MixinBuilder<AddVehicleController>(
          init: AddVehicleController(Get.find()),
          initState: (_) {},
          builder: (_) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                        key: _.addVehicleFormHelper.formKey,
                            autovalidateMode:
                            _.addVehicleFormHelper.autovalidateMode.value,
                            child: Column(
                                children: [
                                const SizedBox(height: 20),
                            CustomFormField(
                              controller:
                              _.addVehicleFormHelper.controllers['vin'],
                              label: "VIN/Chassi Number",
                              hintText: "Ex. NW905 AG",
                              forceUpperCase: true,
                              validator:
                              _.addVehicleFormHelper.validators['vin'],
                            ),


                                const SizedBox(height: 20),
                                CustomFormField(
                                  controller: _.addVehicleFormHelper
                                      .controllers['registration'],
                                  label: "Vehicel Registration Number",
                                  hintText: "Ex. SV30-0169266",
                                  forceUpperCase: true,
                                  validator: _.addVehicleFormHelper
                                      .validators['registration'],
                                ),
                              ],
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomButton(
                    text: "Add Vehicle",
                    onPressed: (){
                      onpenModalPaymentMethod(_.addVehicleFormHelper.submit);
                    },
                    isLoading: _.addVehicleFormHelper.isLoading,
                  ),
                ),
              ],
            );
          },
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
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16), // Espacement intérieur
          child: Wrap(
            children: [
              PaymentMethodeWidget(onConfirm:(){
                onConfirm ;
              }),
            ],
          ),
        ),
      );
    },
  );
}