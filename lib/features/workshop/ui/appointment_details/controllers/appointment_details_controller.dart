import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/chat/navigation/private/chat_private_routes.dart';
import 'package:jappcare/features/garage/domain/repositories/garage_repository.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';
import 'package:jappcare/features/workshop/domain/entities/payment.entity.dart';
import 'package:jappcare/features/workshop/domain/repositories/payment_repository.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/widgets/appointment_payments_modal.dart';

class AppointmentDetailsController extends GetxController {
  final AppNavigation _appNavigation;
  final GarageRepository _garageRepository;
  final PaymentRepository _paymentRepository;
  AppointmentDetailsController(
      this._appNavigation, this._garageRepository, this._paymentRepository);
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

  /// Shows a modal with all payments made for this appointment
  Future<void> viewAllPayments() async {
    // Show the modal immediately with loading state
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FutureBuilder<List<PaymentEntity>>(
          future: _fetchAppointmentPayments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AppointmentPaymentsModal(
                payments: [],
                isLoading: true,
              );
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return const AppointmentPaymentsModal(
                payments: [],
                isLoading: false,
              );
            }

            return AppointmentPaymentsModal(
              payments: snapshot.data!,
              isLoading: false,
            );
          },
        );
      },
    );
  }

  /// Fetches payments for this appointment from the API
  Future<List<PaymentEntity>> _fetchAppointmentPayments() async {
    final result = await _paymentRepository.getPaymentsByAppointmentId(
      appointmentId: _appointment.value.id,
    );
    return result.fold(
      (failure) {
        Get.showCustomSnackBar(failure.message,
            title: 'Error', type: CustomSnackbarType.error);
        return <PaymentEntity>[];
      },
      (payments) => payments,
    );
  }
}
