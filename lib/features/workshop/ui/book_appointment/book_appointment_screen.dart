import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/select_vehicule_slider_widget.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/shimmers/list_vehicle_shimmer.dart';
import 'package:jappcare/features/services/ui/generateVehiculeReport/controllers/generate_vehicule_report_controller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/add_image_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/boocking_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/chat_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/custom_map_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/estimate_inspection_fee.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/form_location_widget.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/categories_item_list.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/services_list_widget.dart';

class BookAppointmentScreen extends GetView<BookAppointmentController> {
  // final GenerateVehiculeReportController generateVehiculeReportController = GenerateVehiculeReportController(Get.find());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Book\nAppointment',
          actions: [
            if (Get.isRegistered<FeatureWidgetInterface>(
                tag: 'AvatarWidget'))
              Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget')
                  .buildView(),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child:
                Column(

                  children: [
                    SizedBox(height: 10,),
                    if (Get.isRegistered<FeatureWidgetInterface>(
                        tag: 'ListVehicleWidget'))

                      Get.find<FeatureWidgetInterface>(tag: 'ListVehicleWidget')
                          .buildView({
                        "pageController": controller.pageController,
                        "currentPage": controller.currentPage,
                        "haveAddVehicule": false,
                        "title": "Select Vehicle",
                        "onSelected": (selectedCar) {
                          controller.vehicleId.value = selectedCar.id;
                          controller.vehicleVin.value = selectedCar.vin;
                          controller.globalControllerWorkshop.addVehicle(selectedCar);
                          print("Current page: ${controller.currentPage
                              .value}, Car ID: ${selectedCar.name}");
                        },

                      }),

                    SizedBox(height: 20,),
                   ServicesListWidget(),

                    BookingWidget(),
                    SizedBox(height: 20,),
                    CustomMapWidget(),
                    SizedBox(height: 20,),
                    FormLocationWidget(),
                    SizedBox(height: 50,),
                    AddImageWidget(),
                    // EstimatedInspectionFee(),
                    SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: CustomButton(

                          text: 'Continue',
                          onPressed: () {
                            if(controller.formKey.currentState?.validate() ?? false){
                            controller.gotToConfirmAppointment();
                            }
                          }
                      ),
                    ),
                    SizedBox(height: 50,),

                  ],
                ),
                )
            ),
            // Positioned(
            //     top: MediaQuery
            //         .of(context)
            //         .size
            //         .height * 0.7,
            //     right: 10,
            //     child: ChatWidget()
            // )
          ],
        )

    );
  }

}