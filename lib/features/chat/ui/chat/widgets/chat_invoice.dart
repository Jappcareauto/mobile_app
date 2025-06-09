import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/utils/app_images.dart';

class InvoiceCard extends StatelessWidget {
  final String name;
  final String email;
  final String service;
  final String invoiceNumber;
  final String dateIssued;
  final String amount;
  final String status;
  final VoidCallback onViewInvoice;

  const InvoiceCard({
    super.key,
    required this.name,
    required this.email,
    required this.service,
    required this.invoiceNumber,
    required this.dateIssued,
    required this.amount,
    required this.status,
    required this.onViewInvoice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with name and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Billed to",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(AppImages.avatar),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            email,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              // Status badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: status == "Pending"
                      ? Colors.red.shade100
                      : Colors.green.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: status == "Pending" ? Colors.red : Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Invoice details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Service",
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              Text(
                service,
                style: const TextStyle(fontSize: 14.0),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Invoice Number",
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              Text(
                invoiceNumber,
                style: const TextStyle(fontSize: 14.0),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Date Issued",
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              Text(
                dateIssued,
                style: const TextStyle(fontSize: 14.0),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Amount",
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // View Invoice button
          Align(
              alignment: Alignment.bottomRight,
              child: CustomButton(
                  strech: false,
                  haveBorder: true,
                  borderRadius: BorderRadius.circular(30),
                  width: 170,
                  text: 'View invoice',
                  onPressed: onViewInvoice)),
        ],
      ),
    );
  }
}
