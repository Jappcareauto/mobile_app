import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/authentification/navigation/private/authentification_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

import '../../../../../core/utils/getx_extensions.dart';

import '../../../application/usecases/register_usecase.dart';
import '../../../application/usecases/register_command.dart';
import '../../../../../core/services/form/validators.dart';

import '../../../../../core/services/form/form_helper.dart';

import '../../../domain/core/exceptions/authentification_exception.dart';

import '../../../domain/entities/register.dart';

class SignUpWithEmailController extends GetxController {
  final RegisterUseCase _registerUseCase = Get.find();
  late FormHelper registerFormHelper;
  final acceptedTerms = false.obs;
  final Rx<DateTime?> _selectedDate = Rx<DateTime?>(null);

  final AppNavigation _appNavigation;
  SignUpWithEmailController(this._appNavigation);

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    registerFormHelper = FormHelper<AuthentificationException, Register>(
      fields: {
        "name": null,
        "email": null,
        "password": null,
        "phoneNumber": null,
        "dateOfBirth": null,
      },
      validators: {
        "name": Validators.requiredField,
        "email": Validators.requiredField,
        "password": Validators.requiredField,
        "phoneNumber": Validators.requiredField,
        "dateOfBirth": Validators.requiredField,
      },
      onSubmit: (data) => _registerUseCase.call(RegisterCommand(
        name: data['name']!,
        email: data['email']!,
        password: data['password']!,
        dateOfBirth: data['dateOfBirth']!,
      )),
      onError: (e) => Get.showCustomSnackBar(e.message),
      onSuccess: (response) {
        _appNavigation.goBack();
        _appNavigation.toNamed(AuthentificationPrivateRoutes.verifyYourEmail,
            arguments: response.email);
      },
    );
  }

    Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: _selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate.value) {
      _selectedDate.value = picked;
      registerFormHelper.controllers['dateOfBirth']?.text =
          "${picked.year}-${picked.month < 10 ? "0${picked.month}" : picked.month}-${picked.day < 10 ? "0${picked.day}" : picked.day}";
      update();
    }
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void goToLoginPage() {
    _appNavigation.goBack();
    _appNavigation.toNamed(AuthentificationPrivateRoutes.loginWithEmail);
  }

  void goToEmailVerificationPage(String? email) {
    _appNavigation.toNamed(AuthentificationPrivateRoutes.verifyYourEmail,
        arguments: email);
  }

  void acceptTermsAndConditions(bool value) {
    acceptedTerms.value = value;
  }
}
