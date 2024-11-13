import 'package:get/get.dart';
import 'package:jappcare/core/services/form/form_helper.dart';
import 'package:jappcare/core/services/form/validators.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/authentification/domain/core/exceptions/authentification_exception.dart';
import 'package:jappcare/features/authentification/navigation/private/authentification_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../domain/entities/login.dart';

class LoginWithPhoneController extends GetxController {
  final AppNavigation _appNavigation;
  LoginWithPhoneController(this._appNavigation);

  late FormHelper loginFormHelper;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    loginFormHelper = FormHelper<AuthentificationException, Login>(
      fields: {
        "phone": null,
        "password": null,
      },
      validators: {
        "phone": Validators.requiredField,
        "password": Validators.requiredField,
      },
      onSubmit: null,/*(data) => _loginUseCase.call(LoginCommand(
        email: data['email']!,
        password: data['password']!,
        extend: true,
      )),*/
      onError: (e) {
        Get.showCustomSnackBar(e.message);
        if (e.message.contains("not verified")) {
          _appNavigation.toNamed(AuthentificationPrivateRoutes.verifyYourEmail, arguments: loginFormHelper.controllers["email"]?.text);
        }
      },
      onSuccess: (response) {
        // print(response);
        // _localStorageService.write(AppConstants.tokenKey, response.accessToken);
        // _localStorageService.write(
        //     AppConstants.refreshTokenKey, response.refreshToken);
        // _appNavigation.toNamed(AppRoutes.home);
      },
    );
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void navigateToSignUpWithPhone(){
    _appNavigation.toNamed(AuthentificationPrivateRoutes.signUpWithPhone);
  }
}
