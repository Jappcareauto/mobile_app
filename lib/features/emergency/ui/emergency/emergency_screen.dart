import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/features/emergency/ui/emergency/widgets/options_widgets.dart';
import 'controllers/emergency_controller.dart';
import 'package:get/get.dart';

class EmergencyScreen extends GetView<EmergencyController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppBar(title: 'Emergency\nAssistance'),
      body:  SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child:Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'What do you need help with?'
                  )
                ],
              ),
              SizedBox(height: 20,),

              ...List.generate(controller.categorie.length, (index){
                return OptionWidgets(
                    title: controller.categorie[index],
                    ontap: (){
                      controller.selectedCategorie.value = controller.categorie[index] ;
                      controller.selectedindex.value = index ;
                      controller.goToEmergencyDetail();

                    }
                );
              }),
            ],
          ),
        )
        
      )
    );
  }
}
