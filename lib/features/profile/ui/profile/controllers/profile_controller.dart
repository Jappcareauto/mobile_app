import 'package:get/get.dart';
import 'package:jappcare/core/events/app_events_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/features/profile/navigation/private/profile_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../application/usecases/get_user_infos_usecase.dart';
import '../../../domain/entities/get_user_infos.dart';

class ProfileController extends GetxController {
  final GetUserInfosUseCase _getUserInfosUseCase = Get.find();

  final AppNavigation _appNavigation;
  ProfileController(this._appNavigation);

  GetUserInfos? userInfos;
  final loading = false.obs;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    getUserInfos();
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void goToProfile() {
    _appNavigation.toNamed(ProfilePrivateRoutes.home);
  }

  void goToSettings() {
    _appNavigation.toNamed(ProfilePrivateRoutes.settings);
  }

  Future<void> getUserInfos() async {
    loading.value = true;
    final result = await _getUserInfosUseCase.call();
    result.fold(
      (e) {
        loading.value = false;
      },
      (success) {
        loading.value = false;
        userInfos = success;
        Get.find<AppEventService>()
            .emit<String>(AppConstants.userIdEvent, userInfos!.id);
        update();
      },
    );
  }
}
