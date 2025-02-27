import 'package:get/get.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';

class PayWithCardController extends GetxController{
  final AppNavigation _appNavigation ;
  var saveCardPaymentMethode = false.obs ;
  PayWithCardController(this._appNavigation);
  void gotToSuccessPayment (){
    _appNavigation.toNamed(WorkshopPrivateRoutes.successPayment);
  }
}