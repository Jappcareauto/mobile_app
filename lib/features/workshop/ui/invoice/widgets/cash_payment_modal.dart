import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart'
    show CustomFormField;
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/workshop/domain/entities/payment.entity.dart';

class CashPaymentModal extends StatefulWidget {
  final String invoiceId;
  final double totalAmount;
  final double remainingBalance;
  final String currency;
  final Future<PaymentEntity?> Function({
    required double amount,
    String? note,
    File? receiptFile,
  }) onSubmitPayment;

  const CashPaymentModal({
    super.key,
    required this.invoiceId,
    required this.totalAmount,
    required this.remainingBalance,
    required this.currency,
    required this.onSubmitPayment,
  });

  @override
  State<CashPaymentModal> createState() => _CashPaymentModalState();
}

class _CashPaymentModalState extends State<CashPaymentModal> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _receiptFile;
  bool _isLoading = false;
  String? _fileName;

  @override
  void initState() {
    super.initState();
    // Pre-fill with remaining balance
    _amountController.text = widget.remainingBalance.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickReceiptFile() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? photo = await _picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 80,
                );
                if (photo != null) {
                  setState(() {
                    _receiptFile = File(photo.path);
                    _fileName = photo.name;
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 80,
                );
                if (image != null) {
                  setState(() {
                    _receiptFile = File(image.path);
                    _fileName = image.name;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _removeReceipt() {
    setState(() {
      _receiptFile = null;
      _fileName = null;
    });
  }

  String _formatCurrency(double amount) {
    final formatted = amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    if (widget.currency == 'XAF') {
      return '${formatted}frs';
    } else if (widget.currency == 'USD') {
      return '\$$formatted';
    }
    return '$formatted ${widget.currency}';
  }

  Future<void> _submitPayment() async {
    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) {
      Get.showCustomSnackBar('Please enter payment amount',
          title: 'Error', type: CustomSnackbarType.error);
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      Get.showCustomSnackBar('Please enter a valid amount',
          title: 'Error', type: CustomSnackbarType.error);
      return;
    }

    if (amount > widget.remainingBalance) {
      Get.showCustomSnackBar(
          'Amount cannot exceed remaining balance: ${_formatCurrency(widget.remainingBalance)}',
          title: 'Error',
          type: CustomSnackbarType.error);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await widget.onSubmitPayment(
        amount: amount,
        note: _noteController.text.isNotEmpty ? _noteController.text : null,
        receiptFile: _receiptFile,
      );

      if (result != null && mounted) {
        Navigator.of(context).pop(); // Close modal
        if (result.fullyPaid) {
          Get.showCustomSnackBar('Invoice fully paid!',
              title: 'Success', type: CustomSnackbarType.success);
        } else {
          Get.showCustomSnackBar(
              'Payment successful. Remaining: ${_formatCurrency(result.remainingBalance)}',
              title: 'Partial Payment',
              type: CustomSnackbarType.success);
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Cash Payment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Payment Info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Amount:'),
                    Text(
                      _formatCurrency(widget.totalAmount),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Remaining Balance:'),
                    Text(
                      _formatCurrency(widget.remainingBalance),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: widget.remainingBalance > 0
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Amount Input
          const Text(
            'Payment Amount',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          CustomFormField(
            controller: _amountController,
            hintText: 'Enter amount',
            keyboardType: TextInputType.number,
            suffix: Text(
              widget.currency,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),

          // Note Input
          const Text(
            'Note (Optional)',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          CustomFormField(
            controller: _noteController,
            hintText: 'Add payment note...',
            maxLine: 2,
          ),
          const SizedBox(height: 16),

          // Receipt Upload
          const Text(
            'Receipt/Proof of Payment (Optional)',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          if (_receiptFile != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _fileName ?? 'Receipt attached',
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: _removeReceipt,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ] else ...[
            InkWell(
              onTap: _pickReceiptFile,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload_file, color: Get.theme.primaryColor),
                    const SizedBox(width: 8),
                    Text(
                      'Upload Receipt',
                      style: TextStyle(color: Get.theme.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                  haveBorder: true,
                  strech: false,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  text: _isLoading ? 'Processing...' : 'Pay Now',
                  onPressed: _isLoading ? () {} : _submitPayment,
                  strech: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

/// Opens the cash payment modal
void openCashPaymentModal({
  required String invoiceId,
  required double totalAmount,
  required double remainingBalance,
  String currency = 'XAF',
  required Future<PaymentEntity?> Function({
    required double amount,
    String? note,
    File? receiptFile,
  }) onSubmitPayment,
}) {
  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: CashPaymentModal(
        invoiceId: invoiceId,
        totalAmount: totalAmount,
        remainingBalance: remainingBalance,
        currency: currency,
        onSubmitPayment: onSubmitPayment,
      ),
    ),
  );
}
