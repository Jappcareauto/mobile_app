import 'package:get/get.dart';
import 'package:jappcare/core/services/form/form_helper.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/authentification/navigation/private/authentification_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/services/form/validators.dart';
import '../../../domain/core/exceptions/authentification_exception.dart';
import '../../../domain/entities/register.dart';

class SignUpWithPhoneController extends GetxController {
  final AppNavigation _appNavigation;
  SignUpWithPhoneController(this._appNavigation);
  late FormHelper registerFormHelper;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    registerFormHelper = FormHelper<AuthentificationException, Register>(
      fields: {
        "name": null,
        "phone": null,
        "password": null,
        "code": null,
        "number": null,
        "dateOfBirth": null,
      },
      validators: {
        "name": Validators.requiredField,
        "phone": Validators.requiredField,
        "password": Validators.requiredField,
        "code": Validators.requiredField,
        "number": Validators.requiredField,
        "dateOfBirth": Validators.requiredField,
      },
      onSubmit: null, /* (data) => _registerUseCase.call(RegisterCommand(
        name: data['name']!,
        email: data['email']!,
        password: data['password']!,
        phone: PhoneCommand(
          code: data['code']!,
          number: data['number']!,
        ),
        dateOfBirth: data['dateOfBirth']!,
      )),*/
      onError: (e) => Get.showCustomSnackBar(e.message),
      onSuccess: (response) {
        _appNavigation.goBack();
        _appNavigation.toNamed(AuthentificationPrivateRoutes.verifyYourEmail,
            arguments: {'email': response.email});
      },
    );
  }

  void goBack(){
    _appNavigation.goBack();
  }

  void goToLoginPage() {
    _appNavigation.goBack();
    _appNavigation.toNamed(AuthentificationPrivateRoutes.loginWithPhone);
  }
}
