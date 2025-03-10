import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../ui/widgets/loading_widget.dart';
import '../ui/widgets/pick_image.dart';

extension Utils on GetInterface {
  showLoader(
      {bool dismissible = false, bool canUserPop = false, bool dense = false}) {
    dialog(
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
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: color ??
                (isError
                    ? Colors.red.withValues(alpha: .8)
                    : Get.theme.primaryColor.withValues(alpha: .8)),
            title: title,
            message: message,
            duration: const Duration(seconds: 2),
          ));
  }

  Future<List<File>?> getImage({bool many = false}) {
    return showModalBottomSheet<List<File>?>(
        backgroundColor: Colors.transparent,
        context: Get.context!,
        builder: (BuildContext context) {
          return PickImage(
            many: many,
          );
        });
  }
}
