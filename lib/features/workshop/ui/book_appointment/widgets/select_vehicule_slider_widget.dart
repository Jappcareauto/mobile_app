import 'package:flutter/cupertino.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/car_card_add_vehicle.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';

class SelectedVehiculeWidget extends GetView<BookAppointmentController> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, bottom: 20),
              child: Text(
                'Services selected',
                style: Get.textTheme.bodyLarge,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(
            left: 15
          ),
          height: 220, // Contraindre la hauteur du PageView
          child:PageView.builder(
            controller: controller.pageController,
            itemCount: controller.cars.length,
            itemBuilder: (context, index) {
              return Obx(() => CarCardAddVehicle(
                hideblure: true,
                haveBorder: controller.currentPage.value == index,
                containerheight: 200,
                next: () {
                  if (index == controller.cars.length - 1) {
                    controller.pageController.jumpToPage(0);
                  } else {
                    controller.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                carName: controller.cars[index]["carName"]!,
                carDetails: controller.cars[index]["carDetails"]!,
                imagePath: controller.cars[index]["imagePath"]!,
              ));
            },
          ),


        ),
      ],
    );
  }
}
