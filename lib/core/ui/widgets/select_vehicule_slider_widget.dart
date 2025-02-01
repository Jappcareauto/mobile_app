import 'package:flutter/cupertino.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/car_card_add_vehicle.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';

import '../../../features/garage/domain/entities/get_vehicle_list.dart';

class SelectedVehiculeWidget extends StatelessWidget {
  final PageController pageController;
  final List<Vehicle> cars; // Peut être une liste ou un map
  final RxInt currentPage;
  final bool haveAddVehicule;
  final String titleText;
  final VoidCallback? onTapeAddVehicle;

  SelectedVehiculeWidget({
    Key? key,
    required this.pageController,
    required this.cars,
    required this.currentPage,
    required this.haveAddVehicule,
    required this.titleText,
    this.onTapeAddVehicle,
  }) : super(key: key);

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
                titleText,
                style: Get.textTheme.bodyLarge,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 15),
          height: 220, // Contraindre la hauteur du PageView
          child: PageView.builder(
            controller: pageController,
            itemCount: cars.length + (haveAddVehicule ? 1 : 0), // Ajouter un élément si nécessaire
            onPageChanged: (index) {
              currentPage.value = index; // Mettre à jour la page actuelle
            },
            itemBuilder: (context, index) {
              // Dernier élément pour "Add Vehicle"
              if (haveAddVehicule && index == cars.length) {
                return GestureDetector(
                  onTap: onTapeAddVehicle,
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.only(right: 12),
                    width: 360,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Get.theme.primaryColor.withOpacity(.1),
                      border: Border.all(
                        color: Get.theme.primaryColor.withOpacity(.1),
                        width: 3,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '+ Add Vehicle',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                );
              }

              // Afficher les cartes normales pour les voitures
              return Obx(() {
                return CarCardAddVehicle(
                  key: ValueKey(cars[index]),
                  haveBGColor: haveAddVehicule ? true : false,
                  hideblure: true,
                  haveBorder: currentPage.value == index,
                  containerheight: 200,
                  next: () {
                    if (index == cars.length - 1 && !haveAddVehicule) {
                      pageController.jumpToPage(0);
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  carName: cars[index].name?? '',
                  carDetails: [
                    cars[index].name ?? 'Unknown VIN',
                    cars[index].detail!.make ?? 'Unknown Name',
                  ],
                  imagePath: cars[index].imageUrl ?? '',
                  imageUrl: cars[index].imageUrl ?? '',
                );
              });
            },
          ),
        ),
      ],
    );
  }
}
