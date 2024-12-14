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
}
