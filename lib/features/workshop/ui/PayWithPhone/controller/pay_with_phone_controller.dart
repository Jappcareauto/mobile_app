import 'package:get/get.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';

class PayWithPhoneController extends GetxController{
  AppNavigation _appNavigation ;
  var savePhoneNumberPaymentMethod = false.obs ;
  PayWithPhoneController(this._appNavigation);
  void onInit(){
    super.onInit();
  }
  void gotToSuccessPayment (){
    _appNavigation.toNamed(WorkshopPrivateRoutes.successPayment);
  }
}