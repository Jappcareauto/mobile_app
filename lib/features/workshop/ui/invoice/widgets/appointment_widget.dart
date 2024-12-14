import 'package:flutter/material.dart';

class AppointmentContainer extends StatelessWidget {
  final String from;
  final String service;
  final String caseId;
  final String issuedDate;
  final String dueDate;
  final String vin ;
  final String vehiculName;
  const AppointmentContainer({
    Key? key,
    required this.vin,
    required this.vehiculName,
    required this.from,
    required this.service,
    required this.caseId,
    required this.issuedDate,
    required this.dueDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xFFFDFBF4),
              borderRadius: BorderRadius.circular(20)
        ),
       // Couleur d'arrière-plan beige
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // From Section
            Text(
              "From",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              from,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            // Service Section
            Text(
              "Service",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              service,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            // Case ID Section
            Text(
              "Case ID",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              caseId,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            // Dates Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Issued Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, size: 18.0, color: Colors.grey),
                        const SizedBox(width: 6.0),
                        Text(
                          "Issued",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      issuedDate,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Due Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, size: 18.0, color: Colors.grey),
                        const SizedBox(width: 6.0),
                        Text(
                          "Due",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      dueDate,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),


                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vehicule",
                    style: TextStyle(
                      color: Color(0xFF797676),

                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    vehiculName,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "VIN",
                    style: TextStyle(
                      color: Color(0xFF797676),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    vin,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
