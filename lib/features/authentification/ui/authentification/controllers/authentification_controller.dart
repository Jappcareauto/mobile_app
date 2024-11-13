import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/services/networkServices/dio_network_service.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/authentification/navigation/private/authentification_private_routes.dart';
import 'package:jappcare/features/authentification/ui/authentification/widgets/signup_modal.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../widgets/login_modal.dart';

class AuthentificationController extends GetxController {
  final AppNavigation _appNavigation;
  AuthentificationController(this._appNavigation);
  final loadingGoogle = false.obs;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void openSignInModal() {
    showModalBottomSheet(
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: Get.context!,
        builder: (BuildContext context) {
          return const LoginModalWidget();
        });
  }

  void openSignUpModal() {
    showModalBottomSheet(
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: Get.context!,
        builder: (BuildContext context) {
          return const SignUpModalWidget();
        });
  }

  void goToLoginWithEmail() {
    _appNavigation.toNamed(AuthentificationPrivateRoutes.loginWithEmail);
  }

  void goToLoginWithPhone() {
    _appNavigation.toNamed(AuthentificationPrivateRoutes.loginWithPhone);
  }

  void goToSignUpWithEmail() {
    goToLoginWithEmail();
    _appNavigation.toNamed(AuthentificationPrivateRoutes.signUpWithEmail);
  }

  void goToSignUpWithPhone() {
    _appNavigation.toNamed(AuthentificationPrivateRoutes.signUpWithPhone);
  }

  void loginWithGoogle() async {
    loadingGoogle.value = true;
    Get.showCustomSnackBar("Nothing is running ;-)\n It's just a demo");
    await Future.delayed(const Duration(seconds: 2));
    loadingGoogle.value = false;
  }

  void navigateToForgotPassword() {
    _appNavigation.toNamed(AuthentificationPrivateRoutes.resetPassword);
  }

  void goToTermsAndConditions() {
    //TODO
  }
}
