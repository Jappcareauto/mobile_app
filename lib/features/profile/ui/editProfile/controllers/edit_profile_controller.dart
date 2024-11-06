import 'package:get/get.dart';
import 'package:jappcare/core/services/form/form_helper.dart';
import 'package:jappcare/core/services/form/validators.dart';
import '../../../../../core/navigation/app_navigation.dart';

class EditProfileController extends GetxController {
  final AppNavigation _appNavigation;
  EditProfileController(this._appNavigation);

  late FormHelper editProfileFormHelper;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    editProfileFormHelper = FormHelper/*<EditProfileException, EditProfile>*/(
      fields: {
        "name": null,
        "email": null,
        "address": null,
        "phoneNumber": null,
      },
      validators: {
        "name": Validators.requiredField,
        "email": Validators.email,
        "address": Validators.requiredField,
        "phoneNumber": Validators.requiredField,
      },
      // onSubmit: (data) => _editProfileUseCase.call(EditProfileCommand(
      //   firstName: data['firstName']!,
      //   lastName: data['lastName']!,
      //   email: data['email']!,
      //   phoneNumber: data['phoneNumber']!,
      // )),
    );
  }

  void goBack() {
    _appNavigation.goBack();
  }
}
