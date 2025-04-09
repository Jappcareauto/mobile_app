import 'package:get/get.dart';
import 'package:jappcare/core/services/form/form_helper.dart';
import 'package:jappcare/core/services/form/validators.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../application/usecases/update_profile_usecase.dart';
import '../../../application/command/update_profile_command.dart';

class EditProfileController extends GetxController {
  final AppNavigation _appNavigation;
final UpdateProfileUseCase _editProfileUseCase = Get.find();

  EditProfileController(this._appNavigation);

  ProfileController currentUserController = Get.find<ProfileController>();

  late FormHelper editProfileFormHelper;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    editProfileFormHelper = FormHelper/*<EditProfileException, EditProfile>*/(
      fields: {
        "name": currentUserController.userInfos?.name,
        "email": currentUserController.userInfos?.email,
        "address": null,
        "phoneNumber": null,
      },
      validators: {
        "name": Validators.requiredField,
        "email": Validators.email,
        "address": Validators.requiredField,
        "phoneNumber": Validators.requiredField,
      },
      onSubmit: (data) => _editProfileUseCase.call(UpdateProfileCommand(
        name: data['name']!,
        email: data['email']!,
        phone: data['phoneNumber']!,
        address: data['address']!,
      )),
    );
  }

  void goBack() {
    _appNavigation.goBack();
  }
}
