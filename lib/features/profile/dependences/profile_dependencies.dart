import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';

import '../domain/repositories/profile_repository.dart';
import '../infrastructure/repositoriesImpl/profile_repository_impl.dart';
import '../ui/profile/widgets/avatar_widget.dart';

import '../application/usecases/get_user_infos_usecase.dart';

import '../application/usecases/update_profile_image_usecase.dart';

class ProfileDependencies {
  static void init() {
    Get.lazyPut<ProfileRepository>(
        () => ProfileRepositoryImpl(networkService: Get.find()),
        fenix: true);

    Get.lazyPut<FeatureWidgetInterface>(() => const AvatarWidget(),
        tag: 'AvatarWidget', fenix: true);
      Get.lazyPut(() => GetUserInfosUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => UpdateProfileImageUseCase(Get.find()), fenix: true);
}
}
