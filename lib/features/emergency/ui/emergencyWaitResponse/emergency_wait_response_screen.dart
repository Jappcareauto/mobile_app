import 'package:flutter/material.dart';
import 'package:jappcare/features/emergency/ui/emergencyWaitResponse/widgets/emergency_widgets.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/widgets/map_widget.dart';
import 'controllers/emergency_wait_response_controller.dart';
import 'package:get/get.dart';

class EmergencyWaitResponseScreen extends GetView<EmergencyWaitResponseController> {
  const EmergencyWaitResponseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body:  Stack(
        children: [
          const MapWiget(),
          Positioned(
            bottom: 20, // Positionné à 20px du bas de l'écran
            left: 16,   // Marges gauche
            right: 16,  // Marges droite
            child: EmergencyWidgets(),
          ),


        ],
      )
    );
  }
}
