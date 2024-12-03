import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/navigation/routes/app_routes.dart';
import 'package:jappcare/core/services/form/form_helper.dart';
import 'package:jappcare/core/services/form/validators.dart';
import 'package:jappcare/core/services/localServices/local_storage_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../domain/core/exceptions/authentification_exception.dart';
import '../../../application/usecases/forgot_password_usecase.dart';
import '../../../application/usecases/forgot_password_command.dart';
import '../../../domain/entities/forgot_password.dart';
import '../../../application/usecases/reset_password_usecase.dart';
import '../../../application/usecases/reset_password_command.dart';

import '../../../domain/entities/reset_password.dart';

class ResetPasswordController extends GetxController {
  final ResetPasswordUseCase _resetPasswordUseCase = Get.find();
  late FormHelper resetPasswordFormHelper;

  final ForgotPasswordUseCase _forgotPasswordUseCase = Get.find();
  late FormHelper forgotPasswordFormHelper;

  final loading = false.obs;
  final LocalStorageService _localStorageService = Get.find();

  final AppNavigation _appNavigation;
  ResetPasswordController(this._appNavigation);

  late FormHelper formHelper;
  final index = 0.obs;

  final codeController = TextEditingController();
  String email = '';

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    resetPasswordFormHelper =
        FormHelper<AuthentificationException, ResetPassword>(
      fields: {
        "newPassword": null,
      },
      validators: {
        "newPassword": Validators.requiredField,
      },
      onSubmit: (data) => _resetPasswordUseCase.call(ResetPasswordCommand(
        code: codeController.text,
        newPassword: data['newPassword']!,
      )),
      onError: (e) => Get.showCustomSnackBar(e.message),
      onSuccess: (response) {
        _localStorageService.write(AppConstants.tokenKey, response.accessToken);
        _localStorageService.write(
            AppConstants.refreshTokenKey, response.refreshToken);
        _appNavigation.toNamed(AppRoutes.home);
      },
    );

    forgotPasswordFormHelper =
        FormHelper<AuthentificationException, ForgotPassword>(
      fields: {
        "email": null,
      },
      validators: {
        "email": Validators.email,
      },
      onSubmit: (data) {
        email = data['email']!;
        return _forgotPasswordUseCase.call(ForgotPasswordCommand(
          email: data['email']!,
        ));
      },
      onError: (e) => Get.showCustomSnackBar(e.message),
      onSuccess: (response) {
        index(1);
        update();
      },
    );

    formHelper = FormHelper<AuthentificationException, ForgotPassword>(
      fields: {
        "code": null,
      },
      validators: {
        "code": Validators.requiredField,
      },
      onSubmit: (data) async {
        await Future.delayed(const Duration(seconds: 2));
        codeController.text = data['code']!;
        index(2);
        return Future.value(null);
      },
    );
  }

  void goBack() {
    _appNavigation.goBack();
  }
}
