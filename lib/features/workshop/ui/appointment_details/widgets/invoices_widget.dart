import 'package:flutter/material.dart';

class InvoiceDetails extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final double total;
  final double tax;
  final double amount;

  const InvoiceDetails({
    super.key,
    required this.items, // Liste des articles : nom, quantité, prix
    required this.total, // Total sans taxe
    required this.tax,   // Montant des taxes
    required this.amount, // Montant total à payer
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
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre "Details"
          const Text(
            "Details",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 12.0),

          // Tableau des articles
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3), // Item
              1: FlexColumnWidth(1), // Qty
              2: FlexColumnWidth(2), // Amount
            },
            children: [
              // En-têtes du tableau
              const TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Item",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Qty",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Amount",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // Détails des items
              ...items.map((item) {
                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(item['name']),
                    ),
                    Text(
                      item['quantity'].toString(),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${item['price']} frs",
                      textAlign: TextAlign.right,
                    ),
                  ],
                );
              }),
            ],
          ),
          const SizedBox(height: 16.0),

          // Totaux
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                _buildRow("Total", total, isBold: false),
                _buildRow("Tax 5%", tax, isBold: false),
                  const SizedBox(height: 15,),
                _buildRow("Amount", amount, isBold: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.orange : Colors.black,
            ),
          ),
          Text(
            "${value.toStringAsFixed(0)} frs",
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.orange : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
