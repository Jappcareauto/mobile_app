import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/services/form/validators.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';

class FormLocationWidget extends GetView<BookAppointmentController>{
  @override
  Widget build(BuildContext context) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            CustomFormField(
              focusedBorderColor: AppColors.greyText.withOpacity(.1),
              filColor: AppColors.white,
              validator: Validators.requiredField,
              hintText: 'Search for a place',
              label: 'Location',
              controller: controller.locationController,
            ),
            SizedBox(height: 20,),
            CustomFormField(
              controller: controller.noteController,
              focusedBorderColor: AppColors.greyText.withOpacity(.1),
              filColor: AppColors.white,
              maxLine: 7,
              hintText: 'Add a Note (Optional)',
            )
          ],
        ),
      );
  }

}