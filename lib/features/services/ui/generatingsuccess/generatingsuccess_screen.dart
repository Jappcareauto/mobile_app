import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'controllers/generatingsuccess_controller.dart';
import 'package:get/get.dart';

class GeneratingsuccessScreen extends GetView<GeneratingsuccessController> {
  const GeneratingsuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: const CustomAppBar(title: 'Vehicle \n Report'),
      body : Center(
          child: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*.2),
            child:  Column(
                children:[
                  GestureDetector(
                    onTap: (){
                      // controller.goToRecepit();
                    },
                    child: const ImageComponent(
                        assetPath:AppImages.boiteLettre
                    ),
                  ),

                  const Text(
                    'Report generated',
                    style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 16),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child:  CustomButton(
                        text: 'Continue' ,
                        onPressed: (){
                          controller.goTovehiculeReport();
                        }
                    ) ,
                  )
                 


                ]
            ) ,
          )

      )
    );
  }
}
