import 'package:get/get.dart';
import '../../../../../core/navigation/app_navigation.dart';

class WorkshopController extends GetxController {
  final AppNavigation _appNavigation;
  WorkshopController(this._appNavigation);

  final selectedCategoryIndex = 0.obs;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack() {
    _appNavigation.goBack();
  }
}
