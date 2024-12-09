import 'package:get/get.dart';
import 'package:jappcare/features/workshop/navigation/bindings/book_appointment_binding.dart';
import 'package:jappcare/features/workshop/navigation/bindings/chat_appointment_binding.dart';
import 'package:jappcare/features/workshop/navigation/bindings/confirme_appointement_binding.dart';
import 'package:jappcare/features/workshop/navigation/bindings/detail_autoshop_binding.dart';
import 'package:jappcare/features/workshop/navigation/bindings/services_locator_binding.dart';
import 'package:jappcare/features/workshop/ui/autoshop_detail/autoshop_screen.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/book_appointment_screen.dart';
import 'package:jappcare/features/workshop/ui/chat/chat_screen.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/confirm_appointment_screen.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/services_center_location_screen.dart';

import '../bindings/workshop_details_controller_binding.dart';
import '../../ui/workshopDetails/workshop_details_screen.dart';
import '../../../../core/navigation/routes/features_pages.dart';
import '../../ui/workshop/workshop_screen.dart';
import '../bindings/workshop_controller_binding.dart';
import 'workshop_private_routes.dart';

class WorkshopPages implements FeaturePages {
  @override
  List<GetPage>  getPages() => [
    GetPage(
      name: WorkshopPrivateRoutes.home,
      page: () => WorkshopScreen(),
      binding: WorkshopControllerBinding(),
    ),
    GetPage(
      name: WorkshopPrivateRoutes.workshopDetails,
      page: () => WorkshopDetailsScreen(),
      binding: WorkshopDetailsControllerBinding(),
    ),
    // Add other routes here
    GetPage(
      name: WorkshopPrivateRoutes.sevicesLocator,
      page: () => ServicesCenterLocator(),
      binding: ServicesLocatorBinding(),
    ),
    GetPage(
      name: WorkshopPrivateRoutes.detailautoshop,
      page: () => AutoshopScreen(),
      binding: DetailAutoshopBinding(),
    ),
    GetPage(
        name: WorkshopPrivateRoutes.bookappointment,
        page: () => BookAppointmentScreen(),
        binding: BookAppointmentBinding()
    ),
    GetPage(
        name: WorkshopPrivateRoutes.confirmappointment,
        page: () => ConfirmeAppointmentScreen(),
        binding: ConfirmAppointmentBinding()
    ),
    GetPage(
        name: WorkshopPrivateRoutes.processChat,
        page: () => ChatDetailsScreen(),
        binding: ChatAppointmentBinding()
    )
  ];
}
