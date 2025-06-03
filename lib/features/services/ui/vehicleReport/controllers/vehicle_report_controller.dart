import 'package:get/get.dart';
import '../../../../../core/navigation/app_navigation.dart';

class VehicleReportController extends GetxController {
  final AppNavigation _appNavigation;
  VehicleReportController(this._appNavigation);
  RxInt selectedFilter = 0.obs;
  var selectedTabs = ''.obs;
  List<String> texts = [
    "Overview",
    "Spec",
    "Purpose",
    "History",
    "Mileage",
    "Damage"
  ];
  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack() {
    _appNavigation.goBack();
  }

  final Map<String, List<Map<String, String>>> details = {
    "Spec": [
      {
        "Make": "Porsche",
      },
      {"Model": "Taycan"},
      {"Trim": "Turbo S"},
      {"Year": "2024"},
      {"Transmission": "Automatic"},
      {"Drive Train": "Electric"},
      {"Power": "982 bhp"},
      {"Body Type": "Sedan"},
    ],
    "Purpose": [
      {"Purpose": "Rental"},
    ],
    "History": [
      {"Theft": "Not reported stolen"},
    ],
  };
}
