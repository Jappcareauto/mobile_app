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
        "code": null,
        "number": null,
        "dateOfBirth": null,
      },
      validators: {
        "name": Validators.requiredField,
        "email": Validators.requiredField,
        "password": Validators.requiredField,
        "code": Validators.requiredField,
        "number": Validators.requiredField,
        "dateOfBirth": Validators.requiredField,
      },
      onSubmit: (data) => _registerUseCase.call(RegisterCommand(
        name: data['name']!,
        email: data['email']!,
        password: data['password']!,
        phone: PhoneCommand(
          code: data['code']!,
          number: data['number']!,
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

  void goBack() {
    _appNavigation.goBack();
  }

  void goToLoginPage() {
    _appNavigation.goBack();
    _appNavigation.toNamed(AuthentificationPrivateRoutes.loginWithEmail);
  }
}
