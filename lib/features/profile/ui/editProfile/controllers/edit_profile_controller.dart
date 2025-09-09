import 'package:get/get.dart';
import 'package:jappcare/core/services/form/form_helper.dart';
import 'package:jappcare/core/services/form/validators.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/profile/domain/core/exceptions/profile_exception.dart';
import 'package:jappcare/features/profile/domain/entities/get_user_infos.dart';
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
    print(currentUserController.userInfos?.dateOfBirth);
    editProfileFormHelper = FormHelper<ProfileException, GetUserInfos>(
      fields: {
        "name": currentUserController.userInfos?.name,
        "email": currentUserController.userInfos?.email,
        "address": null,
        "phoneNumber": null,
        "dateOfBirth": currentUserController.userInfos?.dateOfBirth,
      },
      validators: {
        "name": Validators.requiredField,
        "email": Validators.email,
        "address": Validators.requiredField,
        "phoneNumber": Validators.requiredField,
        "dateOfBirth": Validators.requiredField,
      },
      onSubmit: (data) {
        print(data);
        return _editProfileUseCase.call(UpdateProfileCommand(
        name: data['name']!,
        email: data['email']!,
        dateOfBirth: data['dateOfBirth']!,
        phone: data['phoneNumber'],
        address: data['address'],
      ));
      },
      onError: (e) => Get.showCustomSnackBar(e.message),
      onSuccess: (response) {
        // Get.find<GarageController>().getVehicleList(user.id);
        _appNavigation.goBack();
        update();
      },
    );
  }

  void goBack() {
    _appNavigation.goBack();
  }
}
