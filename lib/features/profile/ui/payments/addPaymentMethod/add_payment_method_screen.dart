import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar_with_back_and_avatar.dart';
// import 'controllers/reset_password_controller.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/utils/app_dimensions.dart';
import 'package:jappcare/features/profile/ui/payments/addPaymentMethod/controllers/add_payment_method_controller.dart';

class AddPaymentMethodScreen extends GetView<AddPaymentMethodController> {
  const AddPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithBackAndAvatar(title: "Add Mobile money"),
      body: GetBuilder<AddPaymentMethodController>(
        init: AddPaymentMethodController(Get.find()),
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
                        key: controller.formHelper.formKey,
                        autovalidateMode: controller
                            .formHelper.autovalidateMode.value,
                        child: Column(
                          spacing: 10,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                Text(
                                  "Phone Number",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.black),
                                ),
                                // const SizedBox(height: 8),
                                IntlPhoneField(
                                  controller: controller.formHelper
                                      .controllers['phoneNumber'],
                                  validator: (phoneNumber) {
                                    final validator = controller
                                        .formHelper
                                        .validators['phoneNumber'];
                                    print(
                                        'phoneNumber: $phoneNumber, validator: ${phoneNumber?.number}');
                                    return validator != null
                                        ? validator(phoneNumber?.number)
                                        : null;
                                  },
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  decoration: InputDecoration(
                                    hintText: 'Ex. 655002200',
                                    fillColor: Colors.white,
                                    filled: true,
                                    errorStyle: const TextStyle(
                                        color: Color(0XFFFF553B)),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppDimensions.radiusSmall),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppDimensions.radiusSmall),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFE5E2E1)),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppDimensions.radiusSmall),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppDimensions.radiusSmall),
                                      borderSide: BorderSide(
                                          color: Get.theme.primaryColor),
                                    ),
                                  ),
                                  initialCountryCode:
                                      'CM', // Set a default country code, e.g., for Cameroon
                                  onChanged: (phone) {
                                    // You can get the full phone number with country code here
                                    print(phone.completeNumber);
                                    controller.phoneCode.value =
                                        phone.countryCode;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CustomButton(
                        isLoading: false.obs,
                        text: 'Add Phone',
                        onPressed: () {},
                      ),
                    ],
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
