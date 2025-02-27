import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/features/workshop/ui/invoice/controllers/invoice_controller.dart';

class ReviewModal extends GetView<InvoiceController> {
  const ReviewModal({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus(); //fermer le model
        controller.updateRating(0);
         // Réinitialise la valeur
        print("Rating Reset to: ${controller.rating.value}");
        }, // Permet de fermer le clavier en cliquant ailleurs
      child: Dialog(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width*.9,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              const Text(
                "How would you rate your experience?",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),

              // Star Rating
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      onPressed: () {
                        // Mettre à jour la note en fonction de l'index cliqué
                        controller.updateRating(index + 1);
                      },
                      icon: Icon(
                        index < controller.rating.value
                            ? FluentIcons.star_16_filled
                            : Icons.star_border, // Étoile pleine ou vide
                        color: Colors.orange,
                        size: 32.0,
                      ),
                    );
                  }),
                );
              }),
              const SizedBox(height: 16.0),

              // Review Text Field
              const CustomFormField(
                maxLine: 5,
                hintText: 'Write a review',
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
                     text: 'Canel',
                     haveBorder: true,
                     borderRadius: BorderRadius.circular(30),
                     onPressed: (){
                       Get.back();
                       controller.rating.value = 0 ;
                       print("Rating Reset to: ${controller.rating.value}");
                     }),
                  const SizedBox(width: 5,),
                  // Publish Button
                  CustomButton(
                      strech: false,
                      borderRadius: BorderRadius.circular(30),
                      width: 100,
                      text: 'Publish',
                      onPressed: (){

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

