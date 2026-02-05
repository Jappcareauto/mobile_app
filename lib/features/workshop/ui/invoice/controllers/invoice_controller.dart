import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/garage/domain/repositories/garage_repository.dart';
import 'package:jappcare/features/workshop/application/usecases/make_cash_payment_usecase.dart';
import 'package:jappcare/features/workshop/domain/entities/appointment_invoice.entity.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';
import 'package:jappcare/features/workshop/domain/entities/payment.entity.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/controllers/appointment_details_controller.dart';
import 'package:jappcare/features/workshop/ui/invoice/widgets/review_model_widget.dart';
import '../../../../../core/navigation/app_navigation.dart';

class InvoiceController extends GetxController {
  final AppNavigation _appNavigation;
  final GarageRepository _garageRepository;
  final MakeCashPaymentUseCase _makeCashPaymentUseCase;

  InvoiceController(
    this._appNavigation,
    this._garageRepository,
    this._makeCashPaymentUseCase,
  );

  var rating = 0.obs;
  var isLoading = false.obs;

  // Invoice data
  Rx<AppointmentInvoiceEntity?> invoice = Rx<AppointmentInvoiceEntity?>(null);

  // Appointment data passed from previous screen
  late AppointmentEntity appointment;

  @override
  void onInit() {
    super.onInit();
    print('InvoiceController onInit called');
    print('Get.arguments: ${Get.arguments}');
    print('Get.arguments type: ${Get.arguments?.runtimeType}');

    // Get the appointment from arguments
    if (Get.arguments != null && Get.arguments is AppointmentEntity) {
      appointment = Get.arguments as AppointmentEntity;
      print('Appointment loaded from arguments: ${appointment.id}');
      _fetchInvoice();
    } else {
      // Try to get from AppointmentDetailsController if available
      try {
        final appointmentDetailsController =
            Get.find<AppointmentDetailsController>();
        appointment = appointmentDetailsController.appointment;
        print(
            'Appointment loaded from AppointmentDetailsController: ${appointment.id}');
        _fetchInvoice();
      } catch (e) {
        print('Could not get appointment from controller: $e');
        // Show error to user
        Get.snackbar(
          'Error',
          'Could not load appointment data',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  /// Fetches the invoice for the current appointment
  Future<void> _fetchInvoice() async {
    isLoading.value = true;
    try {
      print('Fetching invoice for appointment: ${appointment.id}');
      final result = await _garageRepository.getInvoiceByAppointmentId(
        appointmentId: appointment.id,
      );
      result.fold(
        (failure) {
          print('Failed to fetch invoice: ${failure.message}');
          Get.snackbar(
            'Error',
            'Failed to load invoice: ${failure.message}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withValues(alpha: 0.8),
            colorText: Colors.white,
          );
        },
        (invoiceData) {
          invoice.value = invoiceData;
          print(
              'Invoice fetched successfully: ${invoiceData.id}, status: ${invoiceData.status}');
        },
      );
    } catch (e, stackTrace) {
      print('Exception fetching invoice: $e');
      print('Stack trace: $stackTrace');
      Get.snackbar(
        'Error',
        'Failed to load invoice: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
    isLoading.value = false;
  }

  void updateRating(int newRating) {
    rating.value = newRating;
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void showReviewModal() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => const ReviewModal(),
    );
  }

  /// Formats the invoice status for display
  String get formattedStatus {
    switch (invoice.value?.status) {
      case 'PENDING':
        return 'Unpaid';
      case 'PAID':
        return 'Paid';
      case 'PARTIALLY_PAID':
        return 'Partially Paid';
      case 'CANCELLED':
        return 'Cancelled';
      case 'OVERDUE':
        return 'Overdue';
      case 'UNPAID':
        return 'Unpaid';
      case 'DECLINED':
        return 'Declined';
      default:
        return invoice.value?.status ?? 'Unknown';
    }
  }

  /// Gets the status color
  Color get statusColor {
    switch (invoice.value?.status) {
      case 'PENDING':
      case 'UNPAID':
        return Colors.red;
      case 'PAID':
        return Colors.green;
      case 'PARTIALLY_PAID':
        return Colors.orange;
      case 'CANCELLED':
      case 'DECLINED':
        return Colors.grey;
      case 'OVERDUE':
        return Colors.deepOrange;
      default:
        return Colors.grey;
    }
  }

  /// Formats amount with currency
  String formatAmount(double? amount) {
    if (amount == null) return '0';
    final currency = invoice.value?.money?.currency ?? 'XAF';
    final formatted = amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    if (currency == 'XAF') {
      return '${formatted}frs';
    } else if (currency == 'USD') {
      return '\$$formatted';
    }
    return '$formatted $currency';
  }

  /// Formats date for display
  String formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  /// Payment loading state
  var isPaymentLoading = false.obs;

  /// Get total amount from invoice
  double get totalAmount =>
      invoice.value?.money?.amount ?? invoice.value?.totalFromItems ?? 0.0;

  /// Get total paid amount from invoice
  double get totalPaid => invoice.value?.totalPaid ?? 0.0;

  /// Get remaining balance from invoice (fallback to totalAmount if not set)
  double get remainingBalance => invoice.value?.remainingBalance ?? totalAmount;

  /// Get currency
  String get currency => invoice.value?.money?.currency ?? 'XAF';

  /// Make a cash payment
  Future<PaymentEntity?> makeCashPayment({
    required double amount,
    String? note,
    File? receiptFile,
  }) async {
    if (invoice.value == null) {
      Get.showCustomSnackBar('No invoice available',
          title: 'Error', type: CustomSnackbarType.error);
      return null;
    }

    isPaymentLoading.value = true;

    final result = await _makeCashPaymentUseCase.call(
      MakeCashPaymentCommand(
        invoiceId: invoice.value!.id,
        amount: amount,
        currency: currency,
        note: note,
        receiptFile: receiptFile,
      ),
    );

    isPaymentLoading.value = false;

    return result.fold(
      (failure) {
        Get.showCustomSnackBar(failure.message,
            title: 'Payment Failed', type: CustomSnackbarType.error);
        return null;
      },
      (payment) {
        // Refresh invoice data after successful payment
        _fetchInvoice();
        return payment;
      },
    );
  }
}
