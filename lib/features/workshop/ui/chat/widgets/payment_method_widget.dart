import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/ui/chat/controllers/chat_controller.dart';

class PaymentMethodeWidget extends StatelessWidget{
  final ChatController chatController = Get.put(ChatController(Get.find()));
  final VoidCallback onConfirm ;
  PaymentMethodeWidget({
    Key?key,
    required this.onConfirm
}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      Obx(() =>
          Center(
            child: Container(
              // color: Colors.white,
              height: 300,
              margin: EdgeInsets.all(10),


              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        'How would you like to pay ?',
                        style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      chatController.selectMethode('MTN');
                    },
                    child:   Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: chatController.selectedMethod == 'MTN' ? Get.theme.primaryColor.withOpacity(0.2) : null,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color:chatController.selectedMethod == 'MTN' ? Get.theme.primaryColor : Get.theme.scaffoldBackgroundColor , width: 2)
                      ),
                      child: Row(
                        children: [

                          ImageComponent(
                            height: 32,
                            width: 32,
                            assetPath: AppImages.mtnLogo,
                          ),
                          SizedBox(width: 10,),

                          Text(
                              'MTN MoMo',
                            style: TextStyle(color: chatController.selectedMethod == 'MTN' ? Get.theme.primaryColor : Colors.black , fontWeight: FontWeight.bold ),


                          ),

                          SizedBox(width: MediaQuery.of(context).size.width*.35,),


                          GestureDetector(
                            onTap: (){
                              print('add Number');
                            },
                            child: Text(
                                '+ Add Number',
                              style: TextStyle(color: chatController.selectedMethod == 'MTN' ? Get.theme.primaryColor : Colors.grey , ),
                            ),
                          )
                        ],
                      ) ,
                    ),
                  ),

                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      chatController.selectMethode('ORANGE');
                    },
                    child:Container(
                      padding: EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: chatController.selectedMethod == 'ORANGE' ? Get.theme.primaryColor.withOpacity(0.2) : null,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color:chatController.selectedMethod == 'ORANGE' ? Get.theme.primaryColor : Get.theme.scaffoldBackgroundColor , width: 2)),
                      child: Row(
                        children: [

                          ImageComponent(
                            height: 32,
                            width: 32,
                            assetPath: AppImages.orangeLogo,
                          ),
                          SizedBox(width: 5,),

                          Text(
                              'Orange Money',
                            style: TextStyle(color: chatController.selectedMethod == 'ORANGE' ? Get.theme.primaryColor :Colors.black , fontWeight: FontWeight.bold),


                          ),

                          SizedBox(width: MediaQuery.of(context).size.width*.22,),


                          GestureDetector(
                            onTap: (){
                              print('add Number');
                            },
                            child: Text(
                                '+237 00000000',
                              style: TextStyle(color: chatController.selectedMethod == 'ORANGE' ? Get.theme.primaryColor : Colors.grey , ),

                            ),
                          )
                        ],
                      ) ,
                    ),
                  ),

                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      chatController.selectMethode('CARD');
                    },
                    child:Container(
                      padding: EdgeInsets.all(5),

                      decoration: BoxDecoration(
                        color: chatController.selectedMethod == 'CARD' ? Get.theme.primaryColor.withOpacity(0.2) : null,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color:chatController.selectedMethod == 'CARD' ? Get.theme.primaryColor : Get.theme.scaffoldBackgroundColor , width: 2)),
                      child: Row(
                        children: [

                          ImageComponent(
                            height: 32,
                            width: 32,
                            assetPath: AppImages.cardLogo,
                          ),
                          SizedBox(width: 10,),

                          Text(
                              'Card',
                            style: TextStyle(color: chatController.selectedMethod == 'CARD' ? Get.theme.primaryColor : Colors.black , fontWeight: FontWeight.bold),


                          ),

                          SizedBox(width: MediaQuery.of(context).size.width*.38,),


                          GestureDetector(
                            onTap: (){
                              print('add Number');
                            },
                            child: Text(
                                '**** **** **** 1234',
                              style: TextStyle(color: chatController.selectedMethod == 'CARD' ? Get.theme.primaryColor : Colors.grey , ),

                            ),
                          )
                        ],
                      ) ,
                    ),
                  ),

                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        text: 'Cancel',
                        onPressed: (){
                          Get.back();
                        },
                        haveBorder: true,
                        strech: false,
                        width: 170,

                      ),
                      CustomButton(
                        text: 'Confirm',
                        onPressed:onConfirm,

                        strech: false,
                        width: 170,

                      ),
                    ],
                  )

                ],
              ),
            ) ,
          )
      );


  }

}