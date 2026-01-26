import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/features/workshop/domain/entities/appointment_invoice.entity.dart';

/// Invoice widget matching the design for appointment details screen
class AppointmentInvoiceWidget extends StatefulWidget {
  final AppointmentInvoiceEntity invoice;
  final String? serviceName;
  final VoidCallback? onPayInvoice;

  const AppointmentInvoiceWidget({
    super.key,
    required this.invoice,
    this.serviceName,
    this.onPayInvoice,
  });

  @override
  State<AppointmentInvoiceWidget> createState() =>
      _AppointmentInvoiceWidgetState();
}

class _AppointmentInvoiceWidgetState extends State<AppointmentInvoiceWidget> {
  bool _isDiagnosedIssueExpanded = true;
  bool _isRepairsMadeExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Repair Details Title
        const Text(
          'Repair Details',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // Diagnosed Issue Expandable Section
        if (widget.invoice.diagnosedIssue != null &&
            widget.invoice.diagnosedIssue!.isNotEmpty)
          _buildDiagnosedIssueSection(),

        // Repairs Made Expandable Section
        if (widget.invoice.repairedMade != null &&
            widget.invoice.repairedMade!.isNotEmpty) ...[
          const SizedBox(height: 12),
          _buildRepairsMadeSection(),
        ],

        // Details (Items Table)
        if (widget.invoice.items != null &&
            widget.invoice.items!.isNotEmpty) ...[
          const SizedBox(height: 20),
          _buildDetailsSection(),
        ],

        // Total Section
        const SizedBox(height: 16),
        _buildTotalSection(),

        // Pay Invoice Button (inside the invoice widget)
        if (widget.onPayInvoice != null) ...[
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: widget.onPayInvoice,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Pay Invoice',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDiagnosedIssueSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with expand/collapse
          InkWell(
            onTap: () {
              setState(() {
                _isDiagnosedIssueExpanded = !_isDiagnosedIssueExpanded;
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Diagnosed Issue',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.orange,
                    ),
                  ),
                  Icon(
                    _isDiagnosedIssueExpanded
                        ? FluentIcons.chevron_up_16_regular
                        : FluentIcons.chevron_down_16_regular,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          // Content
          if (_isDiagnosedIssueExpanded) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                widget.invoice.diagnosedIssue ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRepairsMadeSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with expand/collapse
          InkWell(
            onTap: () {
              setState(() {
                _isRepairsMadeExpanded = !_isRepairsMadeExpanded;
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Repairs Made',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.orange,
                    ),
                  ),
                  Icon(
                    _isRepairsMadeExpanded
                        ? FluentIcons.chevron_up_16_regular
                        : FluentIcons.chevron_down_16_regular,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          // Content
          if (_isRepairsMadeExpanded) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                widget.invoice.repairedMade ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Details Title
        Text(
          'Details',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.orange,
          ),
        ),
        const SizedBox(height: 12),

        // Table Header
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Item',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Qnty',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Amount',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Divider
        Container(
          height: 1,
          color: Colors.grey.withValues(alpha: 0.2),
        ),

        // Items
        ...widget.invoice.items!.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${item.quantity}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${item.price.toStringAsFixed(0)}frs',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildTotalSection() {
    final currency = widget.invoice.money?.currency ?? 'XAF';
    final subtotal = widget.invoice.totalFromItems;
    final tax = subtotal * 0.05; // 5% tax
    final totalAmount = widget.invoice.money?.amount ?? (subtotal + tax);
    final totalPaid = widget.invoice.totalPaid ?? 0.0;
    final remainingBalance = widget.invoice.remainingBalance ?? totalAmount;
    final status = widget.invoice.status ?? 'PENDING';

    return Column(
      children: [
        // Payment Status Banner
        _buildPaymentStatusBanner(
            status, totalPaid, remainingBalance, currency),
        const SizedBox(height: 12),

        // Totals Container
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.orange.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Total row
              _buildSummaryRow(
                'Total',
                _formatAmount(subtotal, currency),
                isBold: false,
              ),
              const SizedBox(height: 8),

              // Tax row
              _buildSummaryRow(
                'Tax 5%',
                _formatAmount(tax, currency),
                isBold: false,
                isSecondary: true,
              ),
              const SizedBox(height: 12),

              // Amount row (highlighted)
              _buildSummaryRow(
                'Amount',
                _formatAmount(totalAmount, currency),
                isBold: true,
                isHighlighted: true,
              ),

              // Show paid and remaining if there are payments
              if (totalPaid > 0) ...[
                const SizedBox(height: 12),
                Container(
                  height: 1,
                  color: Colors.grey.withValues(alpha: 0.3),
                ),
                const SizedBox(height: 12),
                _buildSummaryRow(
                  'Amount Paid',
                  _formatAmount(totalPaid, currency),
                  isBold: false,
                  isPaid: true,
                ),
                const SizedBox(height: 8),
                _buildSummaryRow(
                  'Remaining',
                  _formatAmount(remainingBalance, currency),
                  isBold: true,
                  isRemaining: true,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentStatusBanner(String status, double totalPaid,
      double remainingBalance, String currency) {
    Color statusColor;
    IconData statusIcon;
    String statusText;
    String? subText;

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
        subText = 'Remaining: ${_formatAmount(remainingBalance, currency)}';
        break;
      case 'OVERDUE':
        statusColor = Colors.red;
        statusIcon = Icons.warning;
        statusText = 'Overdue';
        subText = 'Balance: ${_formatAmount(remainingBalance, currency)}';
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
        subText = 'Amount Due: ${_formatAmount(remainingBalance, currency)}';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor, width: 1),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                if (subText != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    bool isHighlighted = false,
    bool isSecondary = false,
    bool isPaid = false,
    bool isRemaining = false,
  }) {
    Color textColor;
    if (isHighlighted) {
      textColor = AppColors.orange;
    } else if (isPaid) {
      textColor = Colors.green;
    } else if (isRemaining) {
      textColor = Colors.red;
    } else if (isSecondary) {
      textColor = Colors.grey;
    } else {
      textColor = Colors.black87;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isHighlighted || isRemaining ? 15 : 14,
            fontWeight:
                isBold || isRemaining ? FontWeight.bold : FontWeight.normal,
            color: textColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isHighlighted || isRemaining ? 15 : 14,
            fontWeight:
                isBold || isRemaining ? FontWeight.bold : FontWeight.w500,
            color: textColor,
          ),
        ),
      ],
    );
  }

  String _formatAmount(double amount, String currency) {
    // Format with comma separator for thousands
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
}
