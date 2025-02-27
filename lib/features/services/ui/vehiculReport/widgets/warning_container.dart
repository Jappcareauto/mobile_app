import 'package:get/get.dart';
import 'package:jappcare/features/services/ui/vehiculReport/controllers/vehicul_report_controller.dart';
import 'package:flutter/material.dart';

class WarningContainer extends GetView<VehiculReportController>{
  @override
  final String title ;
  final String text ;
  const WarningContainer({
    super.key,
    required this.title,
    required this.text
});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(.1),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
           title, // Titre (ex: Make)
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            text, // Titre (ex: Make)
            style: const TextStyle(
                fontSize: 14,
                color: Colors.red,
              fontWeight: FontWeight.w600
            ),
          ),
        ],
      ),
    );
  }

}