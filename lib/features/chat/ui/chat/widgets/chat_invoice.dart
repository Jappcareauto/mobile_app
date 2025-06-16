import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
// import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/core/ui/widgets/custom_avatar.widget.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/chip_widget.dart';

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
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with name and status
          Align(
            alignment: Alignment.centerRight,
            child: ChipWidget(
              status: status,
              style: ChipStyle.light,
            ),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            //   decoration: BoxDecoration(
            //     color: status == "Pending"
            //         ? Colors.red.shade100
            //         : Colors.green.shade100,
            //     borderRadius: BorderRadius.circular(30),
            //   ),
            //   child: Text(
            //     status,
            //     style: TextStyle(
            //       fontSize: 12.0,
            //       fontWeight: FontWeight.bold,
            //       color: status == "Pending" ? Colors.red : Colors.green,
            //     ),
            //   ),
            // ),
          ),
          Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Service',
                  style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
              Text(service,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),

          Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Billed to',
                  style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
              // const CircleAvatar(
              //   backgroundImage: AssetImage(AppImages.avatar),
              // ),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomAvatarWidget(
                    name: "User",
                    haveName: false,
                    size: 45,
                  ),
                  Text(
                    "User",
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'From',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomAvatarWidget(
                    name: name,
                    haveName: false,
                    size: 45,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         const Text(
          //           "Billed to",
          //           style: TextStyle(
          //             fontSize: 12.0,
          //             color: Colors.grey,
          //           ),
          //         ),
          //         const SizedBox(height: 8),
          //         Row(
          //           children: [
          //             const CircleAvatar(
          //               backgroundImage: AssetImage(AppImages.avatar),
          //             ),
          //             const SizedBox(width: 10),
          //             Column(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   name,
          //                   style: const TextStyle(
          //                     fontSize: 16.0,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 Text(
          //                   email,
          //                   style: const TextStyle(
          //                     fontSize: 14.0,
          //                     color: Colors.grey,
          //                   ),
          //                 ),
          //               ],
          //             )
          //           ],
          //         )
          //       ],
          //     ),
          //     // Status badge
          //   ],
          // ),
          // const SizedBox(height: 16),
          // Invoice details
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Text(
          //       "Service",
          //       style: TextStyle(fontSize: 14.0, color: Colors.grey),
          //     ),
          //     Text(
          //       service,
          //       style: const TextStyle(fontSize: 14.0),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 8),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Text(
          //       "Invoice Number",
          //       style: TextStyle(fontSize: 14.0, color: Colors.grey),
          //     ),
          //     Text(
          //       invoiceNumber,
          //       style: const TextStyle(fontSize: 14.0),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 8),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Text(
          //       "Date Issued",
          //       style: TextStyle(fontSize: 14.0, color: Colors.grey),
          //     ),
          //     Text(
          //       dateIssued,
          //       style: const TextStyle(fontSize: 14.0),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 8),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Text(
          //       "Amount",
          //       style: TextStyle(fontSize: 14.0, color: Colors.grey),
          //     ),
          //     Text(
          //       amount,
          //       style: const TextStyle(
          //         fontSize: 14.0,
          //         color: Colors.red,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ],
          // ),
          Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Case ID',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                "JC78WW0E8E",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Invoice Number',
                  style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
              Text(invoiceNumber,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Date Issued',
                  style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
              Text(
                dateIssued,
                // Format personnalisé
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          // View Invoice button
          Align(
            alignment: Alignment.bottomRight,
            child: CustomButton(
              strech: false,
              haveBorder: true,
              borderRadius: BorderRadius.circular(30),
              width: 140,
              height: 40,
              text: 'View invoice',
              onPressed: onViewInvoice,
            ),
          ),
        ],
      ),
    );
  }
}
