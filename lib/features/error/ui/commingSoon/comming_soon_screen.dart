import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/error/ui/commingSoon/controllers/comming_soon_controller.dart';
import 'package:jappcare/features/error/ui/error/controllers/error_controller.dart';

class CommingSoonScreen extends GetView<CommingSoonController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '',
      ),
      body:  Center(
          child:Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height*.2
            ),
            child:
            Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: ImageComponent(
                    height: 200,
                    width: 200,
                    assetPath: AppImages.commingSoon,
                  ) ,
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Coming Soon' , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w600),),
                  ],
                ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:[
                   Text('This Feature is under development, and will be \n coming soon' ,textAlign: TextAlign.center, style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w400 , ),),
                  ]),
                Spacer(),
                Container(
                  margin: EdgeInsets.all(20),
                  child: CustomButton(
                      text: 'Go Home',
                      onPressed:(){
                        Get.back();
                      }),
                ),



              ],
            ),
          )),
    );


  }

}