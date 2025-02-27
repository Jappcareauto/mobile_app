import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/features/shop/ui/bag/controllers/bag_controller.dart';

class DeleteModel extends GetView<BagController>{
  final String id;
  const DeleteModel({
    super.key,
    required this.id
});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus(); //fermer le model

      }, // Permet de fermer le clavier en cliquant ailleurs
      child: Dialog(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width ,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              const Text(
                "Delete item",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Are you sure you want to delete this item from your cart?",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16.0),

              // Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Cancel Button
                  CustomButton(
                      strech: false,
                      width: 100,
                      text: 'Cancel',
                      haveBorder: true,
                      borderRadius: BorderRadius.circular(30),
                      onPressed: (){
                        Get.back();
                      }),
                  const SizedBox(width: 5,),
                  // Publish Button
                  CustomButton(
                      strech: false,
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.red,
                      width: 100,
                      text: 'Delete',
                      onPressed: (){
                          controller.removeFromCart(id);
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}