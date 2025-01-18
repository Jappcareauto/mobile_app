import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/invoice/widgets/review_model_widget.dart';
import '../../../../../core/navigation/app_navigation.dart';

class InvoiceController extends GetxController {
  final AppNavigation _appNavigation;
  InvoiceController(this._appNavigation);
  var rating = 0.obs; // Note initiale (0 étoiles)


  @override
  void onInit() {

    super.onInit();
  }
  void updateRating(int newRating) {
    rating.value = newRating; // Mettre à jour la note
  }
  void goBack(){
    _appNavigation.goBack();
  }
  void showReviemModel(){
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => const ReviewModal(),
    );
  }

// void showReviemModel() {
//   showModalBottomSheet(
//     context: Get.context!,
//     isScrollControlled: true, // Permet un contrôle précis sur la hauteur
//     backgroundColor: Colors.transparent, // Rendre l'arrière-plan transparent
//     builder: (BuildContext context) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, -2),
//               ),
//             ],
//           ),
//           padding: const EdgeInsets.all(16), // Espacement intérieur
//           child: Wrap(
//             children: const [
//               ReviewModal(), // Votre widget personnalisé
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
}
