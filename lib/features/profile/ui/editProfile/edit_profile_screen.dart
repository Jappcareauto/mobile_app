import 'package:flutter/material.dart';
// import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_date_form_filed.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
// import 'package:jappcare/core/ui/widgets/phone_form_field.dart';
import 'package:jappcare/features/profile/ui/profile/widgets/avatar_widget.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar_with_back_and_avatar.dart';
import 'package:jappcare/features/workshop/domain/entities/place_prediction.dart';
import 'controllers/edit_profile_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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
        builder: (controller) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: controller.editProfileFormHelper.formKey,
                        autovalidateMode: controller
                            .editProfileFormHelper.autovalidateMode.value,
                        child: Column(
                          spacing: 10,
                          children: [
                            const AvatarWidget(size: 100, canEdit: true),
                            const SizedBox(height: 10),
                            CustomFormField(
                              controller: controller
                                  .editProfileFormHelper.controllers['name'],
                              label: "Name",
                              hintText: "Ex. John",
                              validator: controller
                                  .editProfileFormHelper.validators['name'],
                            ),
                            CustomFormField(
                              controller: controller
                                  .editProfileFormHelper.controllers['email'],
                              label: "Email",
                              hintText: "Ex. jOq5i@example.com",
                              keyboardType: TextInputType.emailAddress,
                              validator: controller
                                  .editProfileFormHelper.validators['email'],
                            ),
                            CustomDateFormField(
                              label: 'Date of Birth',
                              datehintstyle: Colors.grey,
                              controller: controller.editProfileFormHelper
                                  .controllers['dateOfBirth'],
                              validator: controller.editProfileFormHelper
                                  .validators['dateOfBirth'],
                            ),

                            TypeAheadField<PlacePrediction>(
                              controller: controller
                                  .editProfileFormHelper.controllers['address'],
                              builder: (_, controller, focusNode) {
                                return CustomFormField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  label: "Home Address",
                                  hintText: "Ex. 123 Main St, Anytown, USA",
                                  keyboardType: TextInputType.streetAddress,
                                );
                              },
                              suggestionsCallback: (pattern) async {
                                if (pattern.isEmpty && controller.placeDetails.value != null) {
                                  controller.placeDetails.value = null;
                                  return [];
                                }
                                var result = await controller.getPlaceAutocomplete(pattern);

                                return result;
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  minTileHeight: 30,
                                  // leading: const Icon(Icons.pin_drop,),
                                  title: Text(suggestion.description, style: TextStyle(fontSize: 14)),
                                );
                              },
                              onSelected: (suggestion) async {
                                // When a suggestion is selected, get the place details.
                                final location = await controller
                                    .getPlaceDetails(suggestion.placeId);

                                if (location != null) {
                                  controller.placeDetails.value = location;
                                  controller.placeInput.value = location.name;
                                  if (controller.editProfileFormHelper
                                          .controllers['address'] !=
                                      null) {
                                    controller
                                        .editProfileFormHelper
                                        .controllers['address']!
                                        .text = location.name;
                                  }
                                }

                                // Invalidate the session token after a place is selected.
                                controller.sessionToken.value = null;
                              },
                              loadingBuilder: (context) => const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Loading...')),
                              errorBuilder: (context, error) => const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Error!'),
                              ),
                              emptyBuilder: (context) => const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('No items found!'),
                              ),
                            ),

                            // CustomPhoneFormField(
                            //   controller: controller.editProfileFormHelper
                            //       .controllers['phoneNumber'],
                            //   label: "Phone Number",
                            //   hintText: "Ex. 123456789",
                            //   validator: controller.editProfileFormHelper
                            //       .validators['phoneNumber'],
                            // ),
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
                    onPressed: () {
                      // print(controller.editProfileFormHelper.formKey.currentState);
                      controller.editProfileFormHelper.submit();
                      print("Save profile changes");
                    },
                    isLoading: controller.editProfileFormHelper.isLoading,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
