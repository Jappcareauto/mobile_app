import 'package:get/get.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/navigation/routes/app_routes.dart';
import '../../../../../core/utils/getx_extensions.dart';
import '../../../application/usecases/verify_email_usecase.dart';
import '../../../application/usecases/verify_email_command.dart';
import '../../../../../core/services/form/validators.dart';
import '../../../../../core/services/form/form_helper.dart';
import '../../../domain/core/exceptions/authentification_exception.dart';
import '../views/email_verify_successfully.dart';

import '../../../application/usecases/resend_otp_usecase.dart';
import '../../../application/usecases/resend_otp_command.dart';

class VerifyYourEmailController extends GetxController {
  final ResendOtpUseCase _resendOtpUseCase = Get.find();

  final VerifyEmailUseCase _verifyEmailUseCase = Get.find();
  late FormHelper verifyEmailFormHelper;

  final AppNavigation _appNavigation;
  VerifyYourEmailController(this._appNavigation);

  late String email;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();

    email = Get.arguments;

    verifyEmailFormHelper = FormHelper<AuthentificationException, bool>(
      fields: {
        "code": null,
      },
      validators: {
        "code": Validators.requiredField,
      },
      onSubmit: (data) =>
          _verifyEmailUseCase.call(VerifyEmailCommand(code: data['code']!)),
      onError: (e) => Get.showCustomSnackBar(e.message),
      onSuccess: (response) {
        _appNavigation.to(const SuccessVerifiedMailScreen());
      },
    );
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void goToHome() {
    _appNavigation.toNamed(AppRoutes.home);
  }

  Future<void> resendOtp() async {
    Get.showLoader();
    final result = await _resendOtpUseCase.call(ResendOtpCommand(email: email));
    result.fold(
      (e) {
        Get.closeLoader();
      },
      (success) {
        Get.closeLoader();
      },
    );
  }
}
