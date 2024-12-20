import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'controllers/confirm_transaction_controller.dart';
import 'package:get/get.dart';

class ConfirmTransactionScreen extends GetView<ConfirmTransactionController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body:  Center(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*.2),
          child:  Column(
              children:[
                GestureDetector(
                  onTap: (){
                    controller.goToRecepit();
                  },
                  child: ImageComponent(
                      assetPath:AppImages.confirmTransaction
                  ),
                ),

                Text(
                  'Waiting for confirmation',
                  style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 16),
                ),
                Text('Please confirm the tranaction on your devices')


              ]
          ) ,
        )

      ),
    );
  }
}
