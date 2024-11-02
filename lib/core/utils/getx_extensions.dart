import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../ui/widgets/loading_widget.dart';

extension Utils on GetInterface {
  showLoader(
      {bool dismissible = false, bool canUserPop = false, bool dense = false}) {
    this.dialog(
        WillPopScope(
            onWillPop: () async {
              return canUserPop;
            },
            child: LoaderWidget(dense: dense)),
        barrierDismissible: dismissible);
  }

  closeLoader() {
    if (isSnackbarOpen) {
      Get.back();
    }
    if (isDialogOpen!) {
      Get.back();
    }
  }

  showCustomSnackBar(String message,
      {String title = "Error", bool isError = true, Color? color}) {
    return Get.context == null || message.isEmpty
        ? null
        : Get.showSnackbar(GetSnackBar(
            snackPosition: SnackPosition.TOP,
            backgroundColor: color ??
                (isError
                    ? Colors.red.withOpacity(.8)
                    : Get.theme.primaryColor.withOpacity(.8)),
            title: title,
            message: message,
            duration: const Duration(seconds: 2),
          ));
  }
}
