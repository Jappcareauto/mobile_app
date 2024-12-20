import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'controllers/generating_loading_controller.dart';
import 'package:get/get.dart';

class GeneratingLoadingScreen extends GetView<GeneratingLoadingController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppBar(title: 'Vehicle \nReport'),
      body:   Center(
          child: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*.2),
            child:  Column(
                children:[
                  GestureDetector(
                    onTap: (){
                      controller.goTosucessPayment();
                    },
                    child: ImageComponent(
                        assetPath:AppImages.confirmTransaction
                    ),
                  ),

                  Text(
                    'Generating your vehicle report',
                    style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 16),
                  ),


                ]
            ) ,
          )

      )
    );
  }
}
