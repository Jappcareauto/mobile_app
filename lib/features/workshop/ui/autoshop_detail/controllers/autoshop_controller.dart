import 'package:get/get.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';

class AutoShopController extends GetxController {
  final AppNavigation _appNavigation;
  AutoShopController(this._appNavigation);
  final isLoading = false.obs;
  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void gotoBookAppointment() {
    _appNavigation.toNamed(WorkshopPrivateRoutes.bookappointment);
    print('go to appointment');
  }
}
