import 'package:get/get.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/features/chat/navigation/private/chat_private_routes.dart';
import 'package:jappcare/features/garage/domain/repositories/garage_repository.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';

class AppointmentDetailsController extends GetxController {
  final AppNavigation _appNavigation;
  final GarageRepository _garageRepository;
  AppointmentDetailsController(this._appNavigation, this._garageRepository);
  RxBool isExpanded = true.obs;
  RxBool isExpandedReportDetail = true.obs;
  RxBool isLoading = false.obs;
  late Rx<AppointmentEntity> _appointment;

  AppointmentEntity get appointment => _appointment.value;

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void toggleisExpandedReportDetail() {
    isExpandedReportDetail.value = !isExpandedReportDetail.value;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize with the passed appointment data
    _appointment = (Get.arguments as AppointmentEntity).obs;
    // Fetch full appointment details to get invoice and other data
    fetchAppointmentDetails();
  }

  /// Fetches the full appointment details including invoice
  Future<void> fetchAppointmentDetails() async {
    isLoading.value = true;
    final result = await _garageRepository.getAppointmentById(
      appointmentId: _appointment.value.id,
    );
    result.fold(
      (failure) {
        print('Failed to fetch appointment details: ${failure.message}');
        // Keep using the passed appointment data
      },
      (appointmentData) {
        _appointment.value = appointmentData;
        print(
            'Appointment details fetched successfully, invoice: ${appointmentData.invoice?.id}');
      },
    );
    isLoading.value = false;
  }

  void goToChatScreen() {
    _appNavigation.toNamed(ChatPrivateRoutes.chat, arguments: appointment);
  }

  void goToInvoice() async {
    await _appNavigation.toNamed(WorkshopPrivateRoutes.invoice,
        arguments: appointment);
    // Refresh appointment details when returning from invoice screen
    fetchAppointmentDetails();
  }

  /// Marks the current appointment as complete
  Future<void> markAsComplete() async {
    // TODO: Implement mark as complete API call
    Get.snackbar(
      'Mark as Complete',
      'This feature will be implemented soon.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
