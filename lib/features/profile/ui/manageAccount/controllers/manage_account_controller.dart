import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/services/localServices/local_storage_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/home/navigation/private/home_private_routes.dart';
import 'package:jappcare/features/profile/domain/repositories/profile_repository.dart';
import '../../../../../core/navigation/app_navigation.dart';

class ManageAccountController extends GetxController {
  final AppNavigation _appNavigation;
  final ProfileRepository _profileRepository;
  ManageAccountController(this._appNavigation, this._profileRepository);

  final _localService = Get.find<LocalStorageService>();

  void requestAccountData() {
    Get.showCustomSnackBar(
      'Your account data request has been submitted. We will contact you shortly.',
      title: 'Success',
      type: CustomSnackbarType.success,
    );
  }

  void deleteAccount() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
            SizedBox(width: 8),
            Expanded(
              child: Text('Delete Account',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to delete your account? This action is permanent and cannot be undone. All your data, including your vehicles, appointments, and payment history will be permanently deleted.',
          style: TextStyle(fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.grey, fontSize: 16)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              Get.back();
              await Future.delayed(const Duration(milliseconds: 300));
              _performDeleteAccount();
            },
            child: const Text('Delete',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _performDeleteAccount() async {
    final userId = _localService.read(AppConstants.userId);
    if (userId == null || (userId is String && userId.isEmpty)) {
      Get.showCustomSnackBar('Unable to identify user. Please try again.',
          title: 'Error', type: CustomSnackbarType.error);
      return;
    }

    Get.showLoader();
    final result =
        await _profileRepository.deleteUser(userId: userId.toString());
    Get.closeLoader();

    result.fold(
      (failure) {
        Get.showCustomSnackBar(failure.message,
            title: 'Error', type: CustomSnackbarType.error);
      },
      (_) async {
        await _localService.delete(AppConstants.tokenKey);
        await _localService.delete(AppConstants.refreshTokenKey);
        await _localService.delete(AppConstants.userId);
        Get.showCustomSnackBar('Your account has been successfully deleted.',
            title: 'Account Deleted', type: CustomSnackbarType.success);
        await _appNavigation.toNamedAndReplaceAll(HomePrivateRoutes.onboarding);
      },
    );
  }
}
