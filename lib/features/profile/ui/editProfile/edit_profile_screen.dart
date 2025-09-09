import 'package:flutter/material.dart';
// import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_date_form_filed.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/ui/widgets/phone_form_field.dart';
import 'package:jappcare/features/profile/ui/profile/widgets/avatar_widget.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar_with_back_and_avatar.dart';
import 'controllers/edit_profile_controller.dart';
import 'package:get/get.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithBackAndAvatar(title: "Edit Profile"),
      // CustomAppBar(
      //   title: "Edit Profile",
      //   canBack: true,
      //   appBarcolor: Get.theme.scaffoldBackgroundColor,
      // ),
      body: GetBuilder<EditProfileController>(
        init: EditProfileController(Get.find()),
        initState: (_) {},
        builder: (controller) {

      return SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    child: Column(
                      children: [
                        const AvatarWidget(size: 100, canEdit: true),
                        const SizedBox(height: 20),
                        CustomFormField(
                          controller:
                              controller.editProfileFormHelper.controllers['name'],
                          label: "Name",
                          hintText: "Ex. John",
                          validator: controller.editProfileFormHelper.validators['name'],
                        ),
                        const SizedBox(height: 10),
                        CustomFormField(
                          controller:
                              controller.editProfileFormHelper.controllers['email'],
                          label: "Email",
                          hintText: "Ex. jOq5i@example.com",
                          keyboardType: TextInputType.emailAddress,
                          validator: controller.editProfileFormHelper.validators['email'],
                        ),
                        const SizedBox(height: 10),
                        CustomDateFormField(
                                            label: 'Date of Birth',
                                            datehintstyle: Colors.grey,
                                            controller: controller.editProfileFormHelper
                                                .controllers['dateOfBirth'],
                                            validator: controller.editProfileFormHelper
                                                .validators['dateOfBirth'],
                                          ),
                        const SizedBox(height: 10),
                        CustomFormField(
                          controller:
                              controller.editProfileFormHelper.controllers['address'],
                          label: "Home Address",
                          validator:
                              controller.editProfileFormHelper.validators['address'],
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CustomButton(
                            text: "Save",
                            onPressed: controller.editProfileFormHelper.submit,
                            isLoading: controller.editProfileFormHelper.isLoading,
                            ),
                      ),
          ],
        ),
      );
      })
      
    );
  }
}
