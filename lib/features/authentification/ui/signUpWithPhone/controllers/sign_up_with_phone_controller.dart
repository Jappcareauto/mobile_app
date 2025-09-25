import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/services/form/form_helper.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/authentification/application/usecases/register_command.dart';
import 'package:jappcare/features/authentification/application/usecases/register_usecase.dart';
import 'package:jappcare/features/authentification/navigation/private/authentification_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/services/form/validators.dart';
import '../../../domain/core/exceptions/authentification_exception.dart';
import '../../../domain/entities/register.dart';

class SignUpWithPhoneController extends GetxController {
  final RegisterUseCase _registerUseCase = Get.find();
  late FormHelper registerFormHelper;
  final acceptedTerms = false.obs;
  final Rx<DateTime?> _selectedDate = Rx<DateTime?>(null);
  final RxString phoneCode = ''.obs;

  final AppNavigation _appNavigation;
  SignUpWithPhoneController(this._appNavigation);

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    registerFormHelper = FormHelper<AuthentificationException, Register>(
      fields: {
        "name": null,
        "phone": null,
        "password": null,
        "dateOfBirth": null,
      },
      validators: {
        "name": Validators.requiredField,
        "phone": Validators.requiredField,
        "password": Validators.requiredField,
        "dateOfBirth": Validators.requiredField,
      },
      onSubmit: (data) => _registerUseCase.call(RegisterCommand(
        name: data['name']!,
        password: data['password']!,
        phone: PhoneCommand(
          code: phoneCode.value.replaceAll("+", ""),
          number: data['phone']!,
        ),
        dateOfBirth: data['dateOfBirth']!,
      )),
      onError: (e) => Get.showCustomSnackBar(e.message),
      onSuccess: (response) {
        _appNavigation.goBack();
        _appNavigation.toNamed(AuthentificationPrivateRoutes.verifyYourEmail,
            arguments: {'email': response.email});
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
    _appNavigation.toNamed(AuthentificationPrivateRoutes.loginWithPhone);
  }

  void acceptTermsAndConditions(bool value) {
    acceptedTerms.value = value;
  }
}
