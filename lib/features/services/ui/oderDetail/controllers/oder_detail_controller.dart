import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/services/navigation/private/services_private_routes.dart';
import 'package:jappcare/features/workshop/ui/chat/widgets/payment_method_widget.dart';
import '../../../../../core/navigation/app_navigation.dart';

class OderDetailController extends GetxController {
  final AppNavigation _appNavigation;
  OderDetailController(this._appNavigation);

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack(){
    _appNavigation.goBack();
  }
  void onpenModalPaymentMethod() {
    showModalBottomSheet(

        enableDrag: true,
        shape: const RoundedRectangleBorder(

          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: Get.context!,
        builder: (BuildContext context) {
          return    PaymentMethodeWidget(
            onConfirm: (){
              _appNavigation.toNamed(ServicesPrivateRoutes.generatingLoading);
            },
          ) ;

        });
  }
}
