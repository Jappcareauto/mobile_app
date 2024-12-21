import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/ui/sucess_payment/controller/success_payment_controller.dart';

class SucessPaymentScreen extends GetView<SuccessPaymentController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '',
        actions: [
          if (Get.isRegistered<FeatureWidgetInterface>(
              tag: 'AvatarWidget'))
            Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget')
                .buildView(),
        ],
      ),
      body:  Center(

        child:Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height*.2
          ),
          child:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: ImageComponent(
                height: 100,
                width: 100,
                assetPath: AppImages.recepit,
              ) ,
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Your Payment of'),
                SizedBox(width: 5,),
                Text('5,000Frs' , style: Get.textTheme.bodyLarge,),
                SizedBox(width: 5,),

                Text('for')
              ],
            ),
            Text('booking fee is successful'),

            Spacer(),
            Container(
              margin: EdgeInsets.all(20),
              child: CustomButton(
                  text: 'Done',
                  onPressed:(){
                    controller.goToAppointmentDetails();
                  }),
            ),



          ],
        ),
      )),
    );


  }

}