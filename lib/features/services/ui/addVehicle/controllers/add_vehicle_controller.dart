import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/chat/widgets/payment_method_widget.dart';
import '../../../../../core/navigation/app_navigation.dart';

class AddVehicleController extends GetxController {
  final AppNavigation _appNavigation;
  AddVehicleController(this._appNavigation);

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack(){
    _appNavigation.goBack();
  }

}
