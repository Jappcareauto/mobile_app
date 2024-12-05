import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';

class FormLocationWidget extends GetView<BookAppointmentController>{
  @override
  Widget build(BuildContext context) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            CustomFormField(
              hintText: 'Search for a place',
              label: 'Location',
            ),
            SizedBox(height: 20,),
            CustomFormField(
              maxLine: 7,
              hintText: 'Add a Note (Optional)',
            )
          ],
        ),
      );
  }

}