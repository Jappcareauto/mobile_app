import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/events/app_events_service.dart';
import 'package:jappcare/core/services/localServices/local_storage_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/features/profile/navigation/private/profile_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../application/usecases/get_user_infos_usecase.dart';
import '../../../domain/entities/get_user_infos.dart';

import '../../../../../core/utils/getx_extensions.dart';

import '../../../application/usecases/update_profile_image_usecase.dart';
import '../../../application/usecases/update_profile_image_command.dart';

class ProfileController extends GetxController {
  final UpdateProfileImageUseCase _updateProfileImageUseCase = Get.find();
  final loading = false.obs;
  final LocalStorageService _localStorageService = Get.find();
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;
  final GetUserInfosUseCase _getUserInfosUseCase = Get.find();

  final AppNavigation _appNavigation;
  ProfileController(this._appNavigation);

  GetUserInfos? userInfos;

  File? file;
  final updateImageLoading = false.obs;

  @override

  /// Behavior:
  /// 1. Subscribes to the userLoginEvent event in the AppEventService.
  /// 2. Calls the getUserInfos method when the userLoginEvent is emitted with a non-empty token.
  /// 3. Calls the getUserInfos method immediately when the controller is initialized.
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    Get.find<AppEventService>()
        .on<String>(AppConstants.userLoginEvent)
        .listen((token) {
      if (token != '') getUserInfos();
    });
    getUserInfos();
    pageController.addListener(() {
      int newPage = pageController.page!.round();
      if (currentPage.value != newPage) {
        currentPage.value = newPage;
      }
    });
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
        _localStorageService.write(AppConstants.userId, success.id);

        Get.find<AppEventService>().emit<String>(AppConstants.userIdEvent, '');
        Get.find<AppEventService>()
            .emit<String>(AppConstants.userIdEvent, userInfos!.id);
        update();
      },
    );
  }

  Future<void> updateProfileImage() async {
    updateImageLoading.value = true;
    final result = await _updateProfileImageUseCase.call(
        UpdateProfileImageCommand(userId: userInfos!.id, file: file!.path));
    result.fold(
      (e) {
        updateImageLoading.value = false;
        if (Get.context != null) Get.showCustomSnackBar(e.message);
      },
      (response) {
        updateImageLoading.value = false;
        print(response);
      },
    );
  }

  void getAndUpdateProfileImage() async {
    final imgs = await Get.getImage();
    if (imgs != null && imgs.isNotEmpty) {
      file = imgs.first;
      update();
      updateProfileImage();
    }
  }
}
