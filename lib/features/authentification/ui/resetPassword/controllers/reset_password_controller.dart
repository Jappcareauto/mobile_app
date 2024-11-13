import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/services/form/form_helper.dart';
import 'package:jappcare/core/services/form/validators.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../domain/core/exceptions/authentification_exception.dart';

class ResetPasswordController extends GetxController {
  final AppNavigation _appNavigation;
  ResetPasswordController(this._appNavigation);

  late FormHelper formHelper;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();

    formHelper = FormHelper<AuthentificationException, bool>(
      fields: {
        "email": null,
      },
      validators: {
        "email": Validators.requiredField,
      },
      onSubmit: null,
      onError: (e) => Get.showCustomSnackBar(e.message),
      onSuccess: (response) {
        // _appNavigation.toNamed(AuthentificationPrivateRoutes.verifyYourEmail, arguments: formHelper.controllers["email"]?.text);
      },
    );
  }

  void goBack() {
    _appNavigation.goBack();
  }
}
