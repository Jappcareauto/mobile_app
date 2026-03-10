import 'package:get/get.dart';
import 'package:jappcare/core/services/form/form_helper.dart';
import 'package:jappcare/core/services/form/validators.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/generated/locales.g.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../authentification/application/usecases/change_password_command.dart';
import '../../../../authentification/application/usecases/change_password_usecase.dart';
import '../../../../authentification/domain/core/exceptions/authentification_exception.dart';

class ChangePasswordController extends GetxController {
  final AppNavigation _appNavigation;
  final ChangePasswordUseCase _changePasswordUseCase = Get.find();
  late FormHelper changePasswordFormHelper;

  ChangePasswordController(this._appNavigation);

  @override
  void onInit() {
    super.onInit();
    changePasswordFormHelper = FormHelper<AuthentificationException, bool>(
      fields: {
        "oldPassword": null,
        "newPassword": null,
        "confirmPassword": null,
      },
      validators: {
        "oldPassword": Validators.password,
        "newPassword": Validators.password,
        "confirmPassword": (value) {
          final passwordError = Validators.password(value);
          if (passwordError != null) return passwordError;
          final newPassword =
              changePasswordFormHelper.controllers['newPassword']?.text ?? '';
          if (value != newPassword) {
            return LocaleKeys.passwords_do_not_match.tr;
          }
          return null;
        },
      },
      onSubmit: (data) => _changePasswordUseCase.call(
        ChangePasswordCommand(
          oldPassword: data['oldPassword']!,
          newPassword: data['newPassword']!,
          confirmPassword: data['confirmPassword']!,
        ),
      ),
      onError: (e) => Get.showCustomSnackBar(e.message),
      onSuccess: (_) {
        Get.showCustomSnackBar(
          LocaleKeys.password_changed_success.tr,
          title: "Success",
          type: CustomSnackbarType.success,
        );
        _appNavigation.goBack();
      },
    );
  }

  void goBack() {
    _appNavigation.goBack();
  }
}
