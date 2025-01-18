import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/core/utils/functions.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:jappcare/features/workshop/ui/chat/widgets/payment_method_widget.dart';
class ChatController extends GetxController {
  final AppNavigation _appNavigation;
  final selectedMethod = 'ORANGE'.obs ;
  ChatController(this._appNavigation);

  var messages = <Map<String, dynamic>>[].obs;
  var selectedImages = <File>[].obs;
  final TextEditingController messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    messages.addAll([
      {
        "text": "Hello , lorem ipsum dolors  ?",

        "isSender": false,
        "images": <File>[]
      },
    ]);
  }
  var paymentDetails = [
    {
      "name":"MTN Momo",
      "icon":AppImages.mtnLogo,
      "numero":"+237691121881"
    },
    {
      "name":"Orange Money",
      "icon":AppImages.orangeLogo,
      "numero":"+237691121881"
    },
    {
      "name":"Card",
      "icon":AppImages.card,
      "numero":"**** **** **** 7890"
    },
    {
      "name":"Cash",
      "icon":AppImages.money,
      "numero":"mmm"
    }
  ];
  Future<void> pickImage() async {
    final images = await getImage(many: true);
    if (images != null) {
      selectedImages.addAll(images);
    }
  }
  void removeImage(int index) {
    selectedImages.removeAt(index);
  }
  void sendMessage() {
    if (messageController.text.isNotEmpty || selectedImages.isNotEmpty) {
      try {
        messages.add({
          "text": messageController.text.isNotEmpty ? messageController.text : null,
          "time": "15:45",
          "isSender": true,
          "images": selectedImages.map((image) => image.path).toList(), // Reste inchangé ici.
        });
        messageController.clear();
        selectedImages.clear();
        update();
      } catch (e) {
        print(e);
      }
    }
  }

  void openMore() {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Placeholder(),
    );
  }
  void onpenModalPaymentMethod() {
    showModalBottomSheet(
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: Get.context!,
        builder: (BuildContext context) {
          return  PaymentMethodeWidget(
            onConfirm: (){
            gotToPaymentForm();
            },
          );
        });
  }
  void goBack() {
    _appNavigation.goBack();
  }
  void selectMethode (String methode){
      selectedMethod.value = methode ;
  }
  void gotToPaymentForm(){
    Get.back();
      if(selectedMethod.value == 'CARD'){

        _appNavigation.toNamed(WorkshopPrivateRoutes.payWithCard);
      }
      if(selectedMethod.value == 'MTN' || selectedMethod.value == 'ORANGE'){
        _appNavigation.toNamed(WorkshopPrivateRoutes.payWithPhone);
      }
  }
}
