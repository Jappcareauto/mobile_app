import 'package:get/get.dart';
import '../../../../../core/navigation/app_navigation.dart';

class GenerateVehicleReportController extends GetxController {
  final AppNavigation _appNavigation;
  GenerateVehicleReportController(this._appNavigation);

  final selectedIndex = 0.obs;
  final loading = false.obs;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack(){
    _appNavigation.goBack();
  }

  void onChangeIndex(int index){
    selectedIndex.value = index;
    update();
  }

  void onGenerateReportPress(){
    loading.value = true;
    update();
    Future.delayed(const Duration(seconds: 2), () {
      loading.value = false;
      update();
    });
  }
}
