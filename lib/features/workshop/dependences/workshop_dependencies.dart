import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/autoshop_detail/controllers/autoshop_controller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/controllers/services_locator_controller.dart';
import 'package:jappcare/features/workshop/ui/workshop/controllers/workshop_controller.dart';
import 'package:jappcare/features/workshop/ui/workshop/workshop_screen.dart';
import '../../../core/ui/interfaces/feature_widget_interface.dart';
import '../domain/repositories/workshop_repository.dart';
import '../infrastructure/repositoriesImpl/workshop_repository_impl.dart';

class WorkshopDependencies {
  static void init() {
    Get.lazyPut<WorkshopRepository>(() => WorkshopRepositoryImpl(networkService: Get.find()), fenix: true);
    Get.lazyPut<FeatureWidgetInterface>(() => WorkshopScreen(),tag: 'WorkshopScreen', fenix: true);
    Get.lazyPut<BookAppointmentController>  (() =>BookAppointmentController(Get.find()));
    Get.lazyPut<AutoShopController>(() => AutoShopController(Get.find()));
    Get.lazyPut<ServicesLocatorController>(() => ServicesLocatorController(Get.find()));
    Get.lazyPut<WorkshopController>(() => WorkshopController(Get.find()));
    Get.lazyPut<ConfirmeAppointmentController>(() => ConfirmeAppointmentController(Get.find()));

  }
}
