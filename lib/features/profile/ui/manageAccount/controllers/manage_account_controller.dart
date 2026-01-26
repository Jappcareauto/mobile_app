import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageAccountController extends GetxController {
  ManageAccountController();

  // void goBack() {
  //   _appNavigation.goBack();
  // }

  void requestAccountData() {
    print("Request Account Data Tapped");
    Get.snackbar(
      "Success",
      "Your account data request has been submitted. We will contact you shortly.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void deleteAccount() {
    print("Delete Account Tapped");
    Get.defaultDialog(
      title: "Delete Account",
      middleText:
          "Are you sure you want to delete your account? This action is irreversible and all your data will be lost.",
      textConfirm: "Delete",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        // TODO: Implement actual delete account logic
        Get.back(); // Close dialog
        print("Account Deleted");
        Get.snackbar(
          "Account Deleted",
          "Your account has been scheduled for deletion.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        // Ideally logout the user
        // _appNavigation.toNamedAndReplaceAll(AppRoutes.login);
      },
      onCancel: () {
        // Get.back() handled automatically by GetX defaultDialog cancel usually, but explicit is fine
      },
    );
  }
}
