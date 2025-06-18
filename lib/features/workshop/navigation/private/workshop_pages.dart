import 'package:get/get.dart';

import '../bindings/invoice_controller_binding.dart';
import '../../ui/invoice/invoice_screen.dart';
import 'package:jappcare/features/workshop/navigation/bindings/apointment_detail_bindings.dart';
import 'package:jappcare/features/workshop/navigation/bindings/book_appointment_binding.dart';
import 'package:jappcare/features/workshop/navigation/bindings/confirm_appointement_binding.dart';
import 'package:jappcare/features/workshop/navigation/bindings/detail_autoshop_binding.dart';
import 'package:jappcare/features/workshop/navigation/bindings/pay_with_card_binding.dart';
import 'package:jappcare/features/workshop/navigation/bindings/pay_with_phone_bindings.dart';
import 'package:jappcare/features/workshop/navigation/bindings/services_locator_binding.dart';
import 'package:jappcare/features/workshop/navigation/bindings/success_payment_binding.dart';
import 'package:jappcare/features/workshop/ui/PayWithCard/pay_with_card_screen.dart';
import 'package:jappcare/features/workshop/ui/PayWithPhone/pay_with_phone_screen.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/appointment_details_screen.dart';
import 'package:jappcare/features/workshop/ui/autoshop_detail/autoshop_screen.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/book_appointment_screen.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/confirm_appointment_screen.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/services_center_location_screen.dart';
import 'package:jappcare/features/workshop/ui/sucess_payment/sucess_payment_screen.dart';

import '../bindings/workshop_details_controller_binding.dart';
import '../../ui/workshopDetails/workshop_details_screen.dart';
import '../../../../core/navigation/routes/features_pages.dart';
import '../../ui/workshop/workshop_screen.dart';
import '../bindings/workshop_controller_binding.dart';
import 'workshop_private_routes.dart';

class WorkshopPages implements FeaturePages {
  @override
  List<GetPage> getPages() => [
        GetPage(
          name: WorkshopPrivateRoutes
              .home, // The name of the route to the workshop screen
          page: () =>
              const WorkshopScreen(), // Here workshop screen view can savely extend the binded controller using for eg. GetView<WorkshopController>
          binding:
              WorkshopControllerBinding(), // Specifying that the WorkshopControllerBinding links the WorkshopController to the WorkshopScreen
        ),
        GetPage(
          name: WorkshopPrivateRoutes.workshopDetails,
          page: () => WorkshopDetailsScreen(),
          binding: WorkshopDetailsControllerBinding(),
        ),
        GetPage(
          name: WorkshopPrivateRoutes.invoice,
          page: () => InvoiceScreen(),
          binding: InvoiceControllerBinding(),
        ),

        // Add other routes here
        GetPage(
          name: WorkshopPrivateRoutes.sevicesLocator,
          page: () => const ServicesCenterLocator(),
          binding: ServicesLocatorBinding(),
        ),
        GetPage(
          name: WorkshopPrivateRoutes.detailautoshop,
          page: () => const AutoshopScreen(),
          binding: DetailAutoshopBinding(),
        ),
        GetPage(
            name: WorkshopPrivateRoutes.bookappointment,
            page: () => BookAppointmentScreen(),
            binding: BookAppointmentBinding()),
        GetPage(
            name: WorkshopPrivateRoutes.confirmappointment,
            page: () => ConfirmeAppointmentScreen(),
            binding: ConfirmAppointmentBinding()),
        GetPage(
            name: WorkshopPrivateRoutes.payWithCard,
            page: () => const PayWithCardScreen(),
            binding: PayWithCardBindings()),
        GetPage(
            name: WorkshopPrivateRoutes.payWithPhone,
            page: () => const PayWithPhoneScreen(),
            binding: PayWithPhoneBindings()),
        GetPage(
            name: WorkshopPrivateRoutes.successPayment,
            page: () => const SucessPaymentScreen(),
            binding: SuccessPaymentBinding()),
        GetPage(
            name: WorkshopPrivateRoutes.appointmentDetail,
            page: () => AppointmentDetailScreen(),
            binding: AppointmentDetailsBinding())
      ];
}
