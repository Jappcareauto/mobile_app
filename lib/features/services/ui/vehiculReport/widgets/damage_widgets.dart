import 'package:get/get.dart';
import 'package:jappcare/features/services/ui/vehiculReport/controllers/vehicul_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/features/services/ui/vehiculReport/widgets/warning_container.dart';

class DamageWidgets extends GetView<VehiculReportController>{
  final String status;
  final String cause;
  final String estimPrice ;
  const DamageWidgets({
    super.key,
    required this.cause,
    required this.estimPrice,
    required this.status
});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WarningContainer(
              title: 'Beware',
              text: 'This vehicle was damaged 2 times'
          ),
          const Text(
            'April 2021', // Titre (ex: Make)
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            status, // Valeur (ex: Porsche)
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red
            ),
          ),
          const SizedBox(height: 10,),
          const Text(
            'Possible damage cause', // Titre (ex: Make)
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            cause, // Valeur (ex: Porsche)
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
          const SizedBox(height: 10,),
          const Text(
            'Estimated repair cost', // Titre (ex: Make)
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            estimPrice, // Valeur (ex: Porsche)
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
        ],
      ),
    );
  }

}