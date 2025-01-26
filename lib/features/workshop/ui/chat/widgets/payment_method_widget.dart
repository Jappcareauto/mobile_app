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

              height: 350,



              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:
                [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'How would you like to pay ?',
                        style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),

                  ...List.generate(chatController.paymentDetails.length, (index) {
                    final paymentDetail = chatController.paymentDetails[index];
                    final isSelected = chatController.selectedMethod == paymentDetail["name"];

                    return InkWell(
                      onTap: () {
                        chatController.selectedMethod.value = paymentDetail["name"]!;
                        print( paymentDetail["name"]!);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? Get.theme.primaryColor.withOpacity(0.2) : null,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? Get.theme.primaryColor : Get.theme.scaffoldBackgroundColor,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            ImageComponent(
                              height: 32,
                              width: 32,
                              assetPath: paymentDetail["icon"],
                            ),
                            const SizedBox(width: 10),
                            Text(
                              paymentDetail["name"]!,
                              style: TextStyle(
                                color: isSelected ? Get.theme.primaryColor : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                print('Add Number for ${paymentDetail["name"]}');
                                chatController.goToAddPaymentMethodForm(paymentDetail["name"]);
                              },
                              child: Text(
                                paymentDetail["numero"]!,
                                style: TextStyle(
                                  color: isSelected ? Get.theme.primaryColor : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 30,),
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
                        width: 160,

                      ),
                      SizedBox(height: 5,),

                      CustomButton(
                        text: 'Confirm',
                        onPressed:(){
                         chatController.goToAddPaymentMethodForm(chatController.selectedMethod.value);
                          print('cliked');
                        }
                        ,

                        strech: false,
                        width: 160,

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