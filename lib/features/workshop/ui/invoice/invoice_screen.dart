import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
// Other payment methods commented out - using cash only for MVP
// import 'package:jappcare/features/chat/ui/chat/widgets/payment_method_widget.dart';
import 'package:jappcare/features/workshop/ui/invoice/widgets/cash_payment_modal.dart';
import 'package:jappcare/features/workshop/ui/invoice/widgets/appointment_widget.dart';
import 'controllers/invoice_controller.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/widgets/invoices_widget.dart';

class InvoiceScreen extends GetView<InvoiceController> {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final invoiceNumber = controller.invoice.value?.number ?? '...';
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Invoice #$invoiceNumber',
          appBarcolor: Get.theme.scaffoldBackgroundColor,
        ),
        body: _buildBody(),
      );
    });
  }

  Widget _buildBody() {
    if (controller.isLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final invoice = controller.invoice.value;
    if (invoice == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.receipt_long, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('No invoice data available'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.goBack(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      );
    }

    // Convert invoice items to the format expected by InvoiceDetails
    final items = invoice.items
            ?.map((item) => {
                  "name": item.name,
                  "quantity": item.quantity,
                  "price": item.price,
                })
            .toList() ??
        [];

    // Calculate totals
    final subtotal = invoice.totalFromItems;
    final tax = subtotal * 0.05; // 5% tax
    final totalAmount = invoice.money?.amount ?? (subtotal + tax);

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Invoiced To Section
              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Invoiced to',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const ClipRRect(
                              child: ImageComponent(
                                assetPath: AppImages.avatar,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    invoice.billedToUser?.name ?? 'N/A',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    invoice.billedToUser?.email ?? 'N/A',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF797676),
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: controller.statusColor.withValues(alpha: .2),
                        ),
                        child: Text(
                          controller.formattedStatus,
                          style: TextStyle(color: controller.statusColor),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Appointment Container
              AppointmentContainer(
                vehiculName: _getVehicleName(),
                vin: controller.appointment.vehicle?.vin ?? 'N/A',
                from: invoice.billedFromUser?.name ?? "Service Center",
                service:
                    "${controller.appointment.service?.title.replaceAll("_", " ")} Appointment",
                caseId: controller.appointment.id,
                issuedDate: controller.formatDate(invoice.issueDate),
                dueDate: controller.formatDate(invoice.dueDate),
              ),
              const SizedBox(height: 16),
              // Invoice Details
              InvoiceDetails(
                items: items,
                total: subtotal,
                tax: tax,
                amount: totalAmount,
              ),
              const SizedBox(height: 20),
              // Payment Summary Section
              _buildPaymentSummary(invoice),
              const SizedBox(height: 16),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButton(
                      strech: false,
                      haveBorder: true,
                      text: 'Review',
                      onPressed: () {
                        controller.showReviewModal();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (invoice.status == 'PENDING' ||
                      invoice.status == 'PARTIALLY_PAID')
                    Expanded(
                      child: CustomButton(
                        strech: false,
                        text: 'Pay with Cash',
                        onPressed: () {
                          openCashPaymentModal(
                            invoiceId: invoice.id,
                            totalAmount: controller.totalAmount,
                            remainingBalance: controller.remainingBalance,
                            currency: controller.currency,
                            onSubmitPayment: controller.makeCashPayment,
                          );
                        },
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getVehicleName() {
    final vehicle = controller.appointment.vehicle;
    if (vehicle == null) return 'Unknown Vehicle';

    final make = vehicle.detail?.make ?? '';
    final model = vehicle.detail?.model ?? '';
    final year = vehicle.detail?.year ?? '';

    if (make.isNotEmpty && model.isNotEmpty) {
      return '$year $make $model'.trim();
    }
    return vehicle.name;
  }

  /// Builds the payment summary section showing payment status
  Widget _buildPaymentSummary(dynamic invoice) {
    final status = invoice.status ?? 'PENDING';
    final totalAmount = controller.totalAmount;
    final totalPaid = controller.totalPaid;
    final remaining = controller.remainingBalance;

    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (status) {
      case 'PAID':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        statusText = 'Fully Paid';
        break;
      case 'PARTIALLY_PAID':
        statusColor = Colors.orange;
        statusIcon = Icons.timelapse;
        statusText = 'Partially Paid';
        break;
      case 'OVERDUE':
        statusColor = Colors.red;
        statusIcon = Icons.warning;
        statusText = 'Overdue';
        break;
      case 'CANCELLED':
      case 'DECLINED':
        statusColor = Colors.grey;
        statusIcon = Icons.cancel;
        statusText = 'Cancelled';
        break;
      default:
        statusColor = Colors.red;
        statusIcon = Icons.pending;
        statusText = 'Unpaid';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor, width: 1),
      ),
      child: Column(
        children: [
          // Status Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(statusIcon, color: statusColor, size: 24),
              const SizedBox(width: 8),
              Text(
                statusText,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Payment Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount:',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                controller.formatAmount(totalAmount),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Amount Paid:',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                controller.formatAmount(totalPaid),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: totalPaid > 0 ? Colors.green : Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Remaining:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      remaining > 0 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Text(
                controller.formatAmount(remaining),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: remaining > 0 ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Old payment method modal - commented out for MVP (cash only)
// void onpenModalPaymentMethod(VoidCallback onConfirm) {
//   showModalBottomSheet(
//     context: Get.context!,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (BuildContext context) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, -2),
//               ),
//             ],
//           ),
//           padding: const EdgeInsets.all(16),
//           child: Wrap(
//             children: [
//               PaymentMethodeWidget(onConfirm: onConfirm),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
