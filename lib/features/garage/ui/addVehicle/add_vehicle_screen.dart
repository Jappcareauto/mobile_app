import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'controllers/add_vehicle_controller.dart';
import 'package:get/get.dart';

class AddVehicleScreen extends GetView<AddVehicleController> {
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
                                SizedBox(height: 20),
                                CustomFormField(
                                  
                                  controller:
                                      _.addVehicleFormHelper.controllers['vin'],
                                  label: "VIN/Chassi Number",
                                  hintText: "Ex. NW905 AG",
                                  forceUpperCase: true,
                                  validator:
                                      _.addVehicleFormHelper.validators['vin'],
                                ),
                                // SizedBox(height: 20),
                                // CustomFormField(
                                //   label: "Vehicel Registration Number",
                                //   hintText: "Ex. SV30-0169266",
                                //   forceUpperCase: true,
                                // ),
                              ],
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomButton(
                    text: "Add Vehicle",
                    onPressed: _.addVehicleFormHelper.submit,
                    isLoading: _.addVehicleFormHelper.isLoading,
                  ),
                ),
              ],
            );
          },
        ));
  }
}
