import 'package:flutter/material.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/widgets/confirmation_appointment_modal.dart';

class ConfirmModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
     child: Container(
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(16),
         boxShadow: [
           BoxShadow(
             color: Colors.black.withOpacity(0.1),
             blurRadius: 10,
             offset: const Offset(0, -2),
           ),
         ],
       ),
       padding: const EdgeInsets.all(16), // Espacement intérieur
       child: Wrap(
         children: [
           ConfirmationAppointmentModal()
         ],
       ),
     ),
   );
  }

}