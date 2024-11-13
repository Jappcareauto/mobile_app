import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/ui/widgets/phone_form_field.dart';
import 'package:jappcare/features/profile/ui/profile/widgets/avatar_widget.dart';
import 'controllers/edit_profile_controller.dart';
import 'package:get/get.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Profile", canBack: true),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
            child: Column(
          children: [
            const AvatarWidget(size: 100, canEdit: true),
            const SizedBox(height: 20),
            CustomFormField(
              controller: controller.editProfileFormHelper.controllers['name'],
              label: "Name",
              hintText: "Ex. John",
              validator: controller.editProfileFormHelper.validators['name'],
            ),
            const SizedBox(height: 10),
            CustomFormField(
              controller: controller.editProfileFormHelper.controllers['email'],
              label: "Email",
              hintText: "Ex. jOq5i@example.com",
              keyboardType: TextInputType.emailAddress,
              validator: controller.editProfileFormHelper.validators['email'],
            ),
            const SizedBox(height: 10),
            CustomFormField(
              controller:
                  controller.editProfileFormHelper.controllers['address'],
              label: "Address",
              validator: controller.editProfileFormHelper.validators['address'],
              hintText: "Ex. 123 Main St, Anytown, USA",
              keyboardType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 10),
            CustomPhoneFormField(
              controller:
                  controller.editProfileFormHelper.controllers['phoneNumber'],
              label: "Phone Number",
              hintText: "Ex. 123456789",
              validator:
                  controller.editProfileFormHelper.validators['phoneNumber'],
            ),
            const SizedBox(height: 20),
            CustomButton(
                text: "Save",
                onPressed: controller.editProfileFormHelper.submit),
          ],
        )),
      )),
    );
  }
}
