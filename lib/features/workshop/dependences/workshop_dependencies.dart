import 'package:get/get.dart';
import 'package:jappcare/features/workshop/application/usecases/book_appointment_usecase.dart';
import 'package:jappcare/features/workshop/domain/repositories/workshop_repository.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/ui/PayWithCard/controllers/pay_with_card_controller.dart';
import 'package:jappcare/features/workshop/ui/PayWithPhone/controller/pay_with_phone_controller.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/controllers/appointment_details_controller.dart';
import 'package:jappcare/features/workshop/ui/autoshop_detail/controllers/autoshop_controller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/map_controller.dart';
import 'package:jappcare/features/workshop/ui/chat/controllers/workshop_chat_controller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/controllers/services_locator_controller.dart';
import 'package:jappcare/features/workshop/ui/sucess_payment/controller/success_payment_controller.dart';
import 'package:jappcare/features/workshop/ui/workshop/controllers/workshop_controller.dart';
import 'package:jappcare/features/workshop/ui/workshop/workshop_screen.dart';
import 'package:jappcare/features/workshop/ui/workshopDetails/controllers/workshop_details_controller.dart';
import '../../../core/ui/interfaces/feature_widget_interface.dart';
import '../infrastructure/repositoriesImpl/workshop_repository_impl.dart';

import '../application/usecases/get_all_services_center_usecase.dart';

import '../application/usecases/get_all_services_usecase.dart';
import '../application/usecases/get_place_autocomplete_usecase.dart';
import '../application/usecases/get_place_details_usecase.dart';

class WorkshopDependencies {
  static void init() {
    Get.lazyPut<WorkshopRepository>(
        () => WorkshopRepositoryImpl(networkService: Get.find()),
        fenix: true);
    Get.lazyPut<FeatureWidgetInterface>(() => const WorkshopScreen(),
        tag: 'WorkshopScreen', fenix: true);
    Get.lazyPut<BookAppointmentController>(
        () => BookAppointmentController(Get.find()));
    Get.lazyPut<AutoShopController>(() => AutoShopController(Get.find()));
    Get.lazyPut<ServicesLocatorController>(
        () => ServicesLocatorController(Get.find()));
    Get.lazyPut<WorkshopController>(() => WorkshopController(
          Get.find(),
        ));
    Get.lazyPut<ConfirmeAppointmentController>(
        () => ConfirmeAppointmentController(Get.find()));
    Get.lazyPut<WorkshopDetailsController>(
        () => WorkshopDetailsController(Get.find()));
    Get.lazyPut<WorkshopChatController>(
        () => WorkshopChatController(Get.find()));
    Get.lazyPut<PayWithCardController>(() => PayWithCardController(Get.find()));
    Get.lazyPut<PayWithPhoneController>(
        () => PayWithPhoneController(Get.find()));
    Get.lazyPut<SuccessPaymentController>(
        () => SuccessPaymentController(Get.find()));
    Get.lazyPut<AppointmentDetailsController>(
        () => AppointmentDetailsController(Get.find()));
    Get.lazyPut(() => GetAllServicesCenterUseCase(Get.find()), fenix: true);
    Get.lazyPut<MapController>(() => MapController(Get.find()));
    Get.lazyPut(() => BookAppointmentUseCase(Get.find()));
    Get.lazyPut<GlobalcontrollerWorkshop>(() => GlobalcontrollerWorkshop());
    // Get.put(WorkshopController(Get.find<AppNavigation>(), Get.find<GetAllServicesCenter>()));
    Get.lazyPut(() => GetAllservicesUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetPlaceAutocompleteUsecase(Get.find()), fenix: true);
    Get.lazyPut(() => GetPlaceDetailsUseCase(Get.find()), fenix: true);
  }
}
