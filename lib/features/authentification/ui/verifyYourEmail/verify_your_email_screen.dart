import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/utils/app_images.dart';
import 'controllers/verify_your_email_controller.dart';
import 'package:get/get.dart';

class VerifyYourEmailScreen extends GetView<VerifyYourEmailController> {
  const VerifyYourEmailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          canBack: true,
          title: "Verify Your\nEmail",
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  'Having issues?',
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<VerifyYourEmailController>(
              initState: (_) {},
              builder: (_) {
                return Form(
                  key: _.verifyEmailFormHelper.formKey,
                  autovalidateMode:
                      _.verifyEmailFormHelper.autovalidateMode.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 40),
                                    child: ImageComponent(
                                        assetPath: AppImages.mail, width: 150),
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "We've sent a verification email to ",
                                        style: Get.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        _.email,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Get.theme.primaryColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Pinput(
                                    length: 6,
                                    keyboardType: TextInputType.text,
                                    defaultPinTheme: PinTheme(
                                      width: 60,
                                      height: 60,
                                      textStyle: const TextStyle(
                                          fontSize: 25,
                                          color: Color.fromRGBO(30, 60, 87, 1),
                                          fontWeight: FontWeight.w600),
                                      decoration: BoxDecoration(
                                        color: Get.theme.primaryColor
                                            .withOpacity(.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onCompleted: (value) =>
                                        _.verifyEmailFormHelper.submit,
                                    // androidSmsAutofillMethod:
                                    //     AndroidSmsAutofillMethod.none,
                                    controller: _.verifyEmailFormHelper
                                        .controllers['code'],
                                    validator: _.verifyEmailFormHelper
                                        .validators['code'],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text("Didn't get the code?"),
                                      TextButton(
                                        onPressed: _.resendOtp,
                                        child: const Text(
                                          "Resend it",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      CustomButton(
                        text: 'Continue',
                        isLoading: _.verifyEmailFormHelper.isLoading,
                        onPressed: _.verifyEmailFormHelper.submit,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              }),
        ));
  }
}
