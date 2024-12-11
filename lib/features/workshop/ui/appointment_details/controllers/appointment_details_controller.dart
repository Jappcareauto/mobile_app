import 'package:get/get.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';

class AppointmentDetailsController  extends GetxController{
  AppNavigation _appNavigation ;
  AppointmentDetailsController(this._appNavigation);
  RxBool isExpanded = true.obs;
  RxBool isExpandedReportDetail = true.obs;

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }
  void toggleisExpandedReportDetail() {
    isExpandedReportDetail.value = !isExpandedReportDetail.value;
  }
  var invoiceItems = [
    {"name": "Spark Plugs", "quantity": 2, "price": 5000},
    {"name": "Engine Oil", "quantity": 1, "price": 2000},
    {"name": "Wiper Blades", "quantity": 1, "price": 3500},
    {"name": "Labour Fee", "quantity": 1, "price": 20000},
  ] ;
  void onInit(){
    super.onInit();
  }

}