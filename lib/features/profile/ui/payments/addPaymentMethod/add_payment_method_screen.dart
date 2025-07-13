import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar_with_back_and_avatar.dart';
// import 'controllers/reset_password_controller.dart';
import 'package:get/get.dart';
// import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/features/profile/ui/payments/addPaymentMethod/controllers/add_payment_method_controller.dart';

class AddPaymentMethodScreen extends GetView<AddPaymentMethodController> {
  const AddPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithBackAndAvatar(title: "Add Momo"),
      body: GetBuilder<AddPaymentMethodController>(
        initState: (_) {},
        builder: (controller) {
          return SafeArea(child: Container());
          // return Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Column(
          //     children: [
          //       CustomButton(
          //         isLoading: false.obs,
          //         text: 'Add Phone',
          //         onPressed: () {},
          //       ),
          //     ],
          //   ),
          // );
        },
      ),
    );
  }
}
