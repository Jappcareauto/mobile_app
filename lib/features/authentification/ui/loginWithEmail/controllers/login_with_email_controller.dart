import 'package:get/get.dart';
import 'package:jappcare/core/navigation/routes/app_routes.dart';
import 'package:jappcare/core/services/localServices/local_storage_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/services/form/form_helper.dart';
import '../../../../../core/services/form/validators.dart';
import '../../../navigation/private/authentification_private_routes.dart';

import '../../../../../core/utils/getx_extensions.dart';

import '../../../application/usecases/login_usecase.dart';
import '../../../application/usecases/login_command.dart';

import '../../../domain/core/exceptions/authentification_exception.dart';

import '../../../domain/entities/login.dart';

class LoginWithEmailController extends GetxController {
  final LoginUseCase _loginUseCase = Get.find();
  final LocalStorageService _localStorageService = Get.find();
  late FormHelper loginFormHelper;

  final AppNavigation _appNavigation;
  LoginWithEmailController(this._appNavigation);

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    loginFormHelper = FormHelper<AuthentificationException, Login>(
      fields: {
        "email": null,
        "password": null,
      },
      validators: {
        "email": Validators.requiredField,
        "password": Validators.requiredField,
      },
      onSubmit: (data) => _loginUseCase.call(LoginCommand(
        email: data['email']!,
        password: data['password']!,
        extend: true,
      )),
      onError: (e) {
        Get.showCustomSnackBar(e.message);
        if (e.message.contains("not verified")) {
          _appNavigation.toNamed(AuthentificationPrivateRoutes.verifyYourEmail, arguments: loginFormHelper.controllers["email"]?.text);
        }
      },
      onSuccess: (response) {
        print(response);
        _localStorageService.write(AppConstants.tokenKey, response.accessToken);
        _localStorageService.write(
            AppConstants.refreshTokenKey, response.refreshToken);
        _appNavigation.toNamed(AppRoutes.home);
      },
    );
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void navigateToSignUp() {
    _appNavigation.toNamed(AuthentificationPrivateRoutes.signUpWithEmail);
  }

  
}
