import 'package:flutter/cupertino.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/car_card_add_vehicle.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';

class SelectedVehiculeWidget extends StatelessWidget {
  final PageController pageController;
  final dynamic cars; // Peut être une liste ou un map
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
    // Vérifier et convertir cars en liste si nécessaire
    final List<Map<String, String>> carList = (cars is List<Map<String, String>>)
        ? cars
        : (cars is Map<String, String>)
        ? [cars]
        : []; // Si cars est autre chose, retournez une liste vide
    print("Cars list: $carList"); // Déboguer ici
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
            itemCount: carList.length + (haveAddVehicule ? 1 : 0), // Ajouter un élément si nécessaire
            onPageChanged: (index) {
              currentPage.value = index; // Mettre à jour la page actuelle
            },
            itemBuilder: (context, index) {
              // Dernier élément pour "Add Vehicle"
              if (haveAddVehicule && index == carList.length) {
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
                  key: ValueKey(carList[index]),
                  haveBGColor: carList.length == 1 ? true : false,
                  hideblure: true,
                  haveBorder: currentPage.value == index,
                  containerheight: 200,
                  next: () {
                    if (index == carList.length - 1 && !haveAddVehicule) {
                      pageController.jumpToPage(0);
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  carName: carList[index]["carName"] ?? '',
                  carDetails: carList[index]["carDetails"] ?? '',
                  imagePath: carList[index]["imagePath"] ?? '',
                );
              });
            },
          ),
        ),
      ],
    );
  }
}
