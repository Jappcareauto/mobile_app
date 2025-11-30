import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import '../ui/widgets/loading_widget.dart';
import '../ui/widgets/pick_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

enum CustomSnackbarType { success, error, info }

extension Utils on GetInterface {
  void showLoader(
      {bool dismissible = false, bool canUserPop = false, bool dense = false}) {
    dialog(
        // WillPopScope(
        //     onWillPop: () async {
        //       return canUserPop;
        //     },
        //     child: LoaderWidget(dense: dense)),
        PopScope(
            canPop: canUserPop,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) {
                return;
              }
              Get.back(result: result);
            },
            child: LoaderWidget(dense: dense)),
        barrierDismissible: dismissible);
  }

  void closeLoader() {
    if (isSnackbarOpen) {
      Get.back();
    }
    if (isDialogOpen!) {
      Get.back();
    }
  }

  SnackbarController? showCustomSnackBar(String message,
      {String title = "Error",
      CustomSnackbarType type = CustomSnackbarType.error,
      Color? color, Duration? duration = const Duration(seconds: 2)}) {
    return Get.context == null || message.isEmpty
        ? null
        : Get.showSnackbar(GetSnackBar(
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: color ??
                (type == CustomSnackbarType.error
                    ? AppColors.secondary
                    : type == CustomSnackbarType.success
                        ? AppColors.success
                        : Colors.white),
            // title: title,
            messageText: Text(
              message,
              style: TextStyle(color: AppColors.blackText, fontSize: 14),
            ),
            icon: Icon(
              type == CustomSnackbarType.error
                  ? FluentIcons.dismiss_circle_20_regular
                  : type == CustomSnackbarType.success
                      ? Icons.check_circle_outline_rounded : Icons.info_outline_rounded,
              size: 24,
              color: type == CustomSnackbarType.error
                  ? Color(0XFFF1351B)
                  : type == CustomSnackbarType.success
                      ? Color(0xFF18B760)
                      : Get.theme.primaryColor,
            ),
            duration: duration,
            borderColor: type == CustomSnackbarType.error
                ? Color(0XFFF1351B)
                : type == CustomSnackbarType.success
                    ? Color(0xFF18B760)
                    : Colors.red,
            borderRadius: 12.0,
            margin: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
          ));
  }

  Future<List<File>?> getImage({bool many = false}) {
    return showModalBottomSheet<List<File>?>(
        backgroundColor: Colors.transparent,
        context: Get.context!,
        builder: (BuildContext context) {
          return PickImage(
            many: many,
            title: "Profile Image",
          );
        });
  }
}
