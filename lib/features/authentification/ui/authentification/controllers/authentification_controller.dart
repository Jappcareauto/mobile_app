// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/events/app_events_service.dart';
import 'package:jappcare/core/navigation/routes/app_routes.dart';
import 'package:jappcare/core/services/localServices/local_storage_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/authentification/navigation/private/authentification_private_routes.dart';
import 'package:jappcare/features/authentification/ui/authentification/widgets/signup_modal.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../application/usecases/google_login_usecase.dart';
import '../../../application/usecases/google_signup_usecase.dart';
import '../widgets/login_modal.dart';

class AuthentificationController extends GetxController {
  final AppNavigation _appNavigation;
  final LocalStorageService _localStorageService = Get.find();
  final GoogleLoginUseCase _googleLoginUseCase = Get.find();
  final GoogleSignupUseCase _googleSignupUseCase = Get.find();
  AuthentificationController(this._appNavigation);
  final loadingGoogle = false.obs;
  final loadingGoogleSignup = false.obs;

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

  void googleLogin() async {
    loadingGoogle.value = true;
    final response = await _googleLoginUseCase.call();

    response.fold((e) {
      loadingGoogle.value = false;
      if (Get.context != null) {
        Get.showCustomSnackBar(e.message);
      }
      update();
    }, (success) {
      loadingGoogle.value = false;
      // print(response);
      _localStorageService.write(AppConstants.tokenKey, success.accessToken);
      // _localStorageService.write(AppConstants.userId, success.id);
      _localStorageService.write(
          AppConstants.refreshTokenKey, success.refreshToken);
      _appNavigation.toNamedAndReplaceAll(AppRoutes.home);
      Get.find<AppEventService>()
          .emit<String>(AppConstants.userLoginEvent, success.accessToken);
    });
  }

  void googleSignup() async {
    loadingGoogle.value = true;
    final response = await _googleSignupUseCase.call();

    response.fold((e) {
      loadingGoogle.value = false;
      if (Get.context != null) {
        Get.showCustomSnackBar(e.message);
      }
    }, (success) {
      loadingGoogle.value = false;
    });
  }

  void navigateToForgotPassword() {
    _appNavigation.toNamed(AuthentificationPrivateRoutes.resetPassword);
  }

  void goToTermsAndConditions() {
    //TODO
  }
}
