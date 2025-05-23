import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/shop/ui/oderSummary/controllers/oder_summary_controller.dart';

class PaymentMethodeWidget extends StatelessWidget{
  final String buttonText ;
  final VoidCallback ontap ;
  PaymentMethodeWidget({
     super.key,
    required this.ontap ,
    required this.buttonText
});
  final OderSummaryController oderSummary = Get.put(OderSummaryController(Get.find()));
  @override
  Widget build(BuildContext context) {
    return
      Obx(() =>
          Center(
            child: SizedBox(
              height: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    children: [
                      Text(
                        'How would you like to pay ?',
                        style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      oderSummary.selectMethode('MTN');
                    },
                    child:   Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: oderSummary.selectedMethod == 'MTN' ? Get.theme.primaryColor.withOpacity(0.2) : null,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color:oderSummary.selectedMethod == 'MTN' ? Get.theme.primaryColor : Get.theme.scaffoldBackgroundColor , width: 2)
                      ),
                      child: Row(
                        children: [

                          const ImageComponent(
                            height: 32,
                            width: 32,
                            assetPath: AppImages.mtnLogo,
                          ),
                          const SizedBox(width: 10,),

                          Text(
                            'MTN MoMo',
                            style: TextStyle(color: oderSummary.selectedMethod == 'MTN' ? Get.theme.primaryColor : Colors.black , fontWeight: FontWeight.bold ),


                          ),

                          SizedBox(width: MediaQuery.of(context).size.width*.35,),


                          GestureDetector(
                            onTap: (){
                              print('add Number');
                            },
                            child: Text(
                              '+ Add Number',
                              style: TextStyle(color: oderSummary.selectedMethod == 'MTN' ? Get.theme.primaryColor : Colors.grey , ),
                            ),
                          )
                        ],
                      ) ,
                    ),
                  ),

                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      oderSummary.selectMethode('ORANGE');
                    },
                    child:Container(
                      padding: const EdgeInsets.all(5),

                      decoration: BoxDecoration(
                          color: oderSummary.selectedMethod == 'ORANGE' ? Get.theme.primaryColor.withOpacity(0.2) : null,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color:oderSummary.selectedMethod == 'ORANGE' ? Get.theme.primaryColor : Get.theme.scaffoldBackgroundColor , width: 2)),
                      child: Row(
                        children: [

                          const ImageComponent(
                            height: 32,
                            width: 32,
                            assetPath: AppImages.orangeLogo,
                          ),
                          const SizedBox(width: 5,),

                          Text(
                            'Orange Money',
                            style: TextStyle(color: oderSummary.selectedMethod == 'ORANGE' ? Get.theme.primaryColor :Colors.black , fontWeight: FontWeight.bold),


                          ),

                          SizedBox(width: MediaQuery.of(context).size.width*.22,),


                          GestureDetector(
                            onTap: (){
                              print('add Number');
                            },
                            child: Text(
                              '+237 00000000',
                              style: TextStyle(color: oderSummary.selectedMethod == 'ORANGE' ? Get.theme.primaryColor : Colors.grey , ),

                            ),
                          )
                        ],
                      ) ,
                    ),
                  ),

                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      oderSummary.selectMethode('CARD');
                    },
                    child:Container(
                      padding: const EdgeInsets.all(5),

                      decoration: BoxDecoration(
                          color: oderSummary.selectedMethod == 'CARD' ? Get.theme.primaryColor.withOpacity(0.2) : null,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color:oderSummary.selectedMethod == 'CARD' ? Get.theme.primaryColor : Get.theme.scaffoldBackgroundColor , width: 2)),
                      child: Row(
                        children: [

                          const ImageComponent(
                            height: 32,
                            width: 32,
                            assetPath: AppImages.cardLogo,
                          ),
                          const SizedBox(width: 10,),

                          Text(
                            'Card',
                            style: TextStyle(color: oderSummary.selectedMethod == 'CARD' ? Get.theme.primaryColor : Colors.black , fontWeight: FontWeight.bold),


                          ),

                          SizedBox(width: MediaQuery.of(context).size.width*.38,),


                          GestureDetector(
                            onTap: (){
                              print('add Number');
                            },
                            child: Text(
                              '**** **** **** 1234',
                              style: TextStyle(color: oderSummary.selectedMethod == 'CARD' ? Get.theme.primaryColor : Colors.grey , ),

                            ),
                          )
                        ],
                      ) ,
                    ),
                  ),

                  const SizedBox(height: 10,),
                      CustomButton(
                        text: buttonText,
                        onPressed:ontap ,


                      ),


                ],
              ),
            ) ,
          )
      );


  }

}