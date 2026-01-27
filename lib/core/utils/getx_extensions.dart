import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
    try {
      if (isSnackbarOpen) {
        closeCurrentSnackbar();
      }
    } catch (_) {
      // Ignore snackbar close errors
    }
    try {
      if (isDialogOpen == true) {
        Get.back();
      }
    } catch (_) {
      // Ignore dialog close errors
    }
  }

  SnackbarController? showCustomSnackBar(String message,
      {String title = "Error",
      CustomSnackbarType type = CustomSnackbarType.error,
      Color? color,
      Duration? duration = const Duration(seconds: 2)}) {
    if (message.isEmpty) {
      return null;
    }

    // Use ScaffoldMessenger as primary method - it's more reliable than GetX
    // GetX's queue system has validation issues that cause GetQueue._check errors
    _showWithScaffoldMessenger(message, type, color, duration);

    return null;
  }

  void _showWithScaffoldMessenger(String message, CustomSnackbarType type,
      Color? color, Duration? duration) {
    // Use post-frame callback to ensure widget tree is ready
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() {
        final context = Get.key.currentContext ?? Get.context;

        if (context == null) {
          _showWithGetX(message, type, color, duration);
          return;
        }

        try {
          final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
          if (scaffoldMessenger != null) {
            scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(
                      type == CustomSnackbarType.error
                          ? FluentIcons.dismiss_circle_20_regular
                          : type == CustomSnackbarType.success
                              ? Icons.check_circle_outline_rounded
                              : Icons.info_outline_rounded,
                      size: 24,
                      color: type == CustomSnackbarType.error
                          ? Color(0XFFF1351B)
                          : type == CustomSnackbarType.success
                              ? Color(0xFF18B760)
                              : Get.theme.primaryColor,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        message,
                        style:
                            TextStyle(color: AppColors.blackText, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                backgroundColor: color ??
                    (type == CustomSnackbarType.error
                        ? AppColors.secondary
                        : type == CustomSnackbarType.success
                            ? AppColors.success
                            : Colors.white),
                duration: duration ?? const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                margin:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(
                    color: type == CustomSnackbarType.error
                        ? Color(0XFFF1351B)
                        : type == CustomSnackbarType.success
                            ? Color(0xFF18B760)
                            : Colors.red,
                    width: 1,
                  ),
                ),
              ),
            );
          } else {
            _showWithGetX(message, type, color, duration);
          }
        } catch (e) {
          _showWithGetX(message, type, color, duration);
        }
      });
    });
  }

  void _showWithGetX(String message, CustomSnackbarType type, Color? color,
      Duration? duration) {
    // Use post-frame callback to ensure GetX navigator is fully ready
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Wait for next frame to ensure navigator is completely built
      Future.delayed(const Duration(milliseconds: 50), () {
        if (message.isEmpty) {
          return;
        }

        // Verify navigator is ready before proceeding
        if (!_isNavigatorReady()) {
          // Wait more if navigator not ready yet
          Future.delayed(const Duration(milliseconds: 200), () {
            if (message.isEmpty) {
              return;
            }
            _attemptShowSnackbar(message, type, color, duration);
          });
          return;
        }

        _attemptShowSnackbar(message, type, color, duration);
      });
    });
  }

  void _attemptShowSnackbar(String message, CustomSnackbarType type,
      Color? color, Duration? duration) {
    // Wait for any ongoing queue operations to complete
    Future.delayed(const Duration(milliseconds: 400), () {
      if (message.isEmpty) {
        return;
      }

      // Verify navigator is ready before showing
      if (!_isNavigatorReady()) {
        // Retry after more delay
        Future.delayed(const Duration(milliseconds: 500), () {
          if (message.isNotEmpty) {
            _actuallyShowGetXSnackbar(message, type, color, duration);
          }
        });
        return;
      }

      try {
        // Try to show the snackbar - let GetX handle queue management
        _actuallyShowGetXSnackbar(message, type, color, duration);
      } catch (e) {
        // If it fails, wait a bit more and retry
        Future.delayed(const Duration(milliseconds: 300), () {
          if (message.isEmpty) {
            return;
          }
          try {
            _actuallyShowGetXSnackbar(message, type, color, duration);
          } catch (e2) {
            // Final fallback - try one more time
            Future.delayed(const Duration(milliseconds: 500), () {
              if (message.isNotEmpty) {
                try {
                  _actuallyShowGetXSnackbar(message, type, color, duration);
                } catch (e3) {
                  // Give up if it still fails
                }
              }
            });
          }
        });
      }
    });
  }

  bool _isNavigatorReady() {
    // Check if GetX navigator is ready
    final navigatorContext = Get.key.currentContext ?? Get.context;

    if (navigatorContext == null) {
      return false;
    }

    // Check if we can access the Navigator
    try {
      Navigator.of(navigatorContext, rootNavigator: true);
      return true;
    } catch (e) {
      return false;
    }
  }

  void _actuallyShowGetXSnackbar(String message, CustomSnackbarType type,
      Color? color, Duration? duration) {
    if (message.isEmpty) {
      return;
    }

    // Verify navigator is ready
    if (!_isNavigatorReady()) {
      // Wait a bit and retry if navigator not ready
      Future.delayed(const Duration(milliseconds: 150), () {
        if (_isNavigatorReady() && message.isNotEmpty) {
          _actuallyShowGetXSnackbar(message, type, color, duration);
        } else {}
      });
      return;
    }

    try {
      // Use Get.showSnackbar - GetX handles Overlay internally
      // Don't check for Overlay ourselves, let GetX do it
      Get.showSnackbar(GetSnackBar(
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: color ??
            (type == CustomSnackbarType.error
                ? AppColors.secondary
                : type == CustomSnackbarType.success
                    ? AppColors.success
                    : Colors.white),
        messageText: Text(
          message,
          style: TextStyle(color: AppColors.blackText, fontSize: 14),
        ),
        icon: Icon(
          type == CustomSnackbarType.error
              ? FluentIcons.dismiss_circle_20_regular
              : type == CustomSnackbarType.success
                  ? Icons.check_circle_outline_rounded
                  : Icons.info_outline_rounded,
          size: 24,
          color: type == CustomSnackbarType.error
              ? Color(0XFFF1351B)
              : type == CustomSnackbarType.success
                  ? Color(0xFF18B760)
                  : Get.theme.primaryColor,
        ),
        duration: duration ?? const Duration(seconds: 2),
        borderColor: type == CustomSnackbarType.error
            ? Color(0XFFF1351B)
            : type == CustomSnackbarType.success
                ? Color(0xFF18B760)
                : Colors.red,
        borderRadius: 12.0,
        margin: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      ));
    } catch (e, stackTrace) {
      // If Overlay error or any other error, retry after delay
      final errorString = e.toString();
      final isOverlayError = errorString.contains("Overlay") ||
          errorString.contains("_Theater") ||
          errorString.contains("No Overlay");
      final isQueueError = errorString.contains("queue") ||
          errorString.contains("Queue") ||
          errorString.contains("_check");

      if (isOverlayError) {
        // Wait longer and retry - navigator might not be ready
        Future.delayed(const Duration(milliseconds: 400), () {
          if (message.isEmpty) {
            return;
          }

          // Verify navigator is ready again
          if (!_isNavigatorReady()) {
            Future.delayed(const Duration(milliseconds: 500), () {
              if (message.isNotEmpty) {
                _actuallyShowGetXSnackbar(message, type, color, duration);
              }
            });
            return;
          }

          try {
            _actuallyShowGetXSnackbar(message, type, color, duration);
          } catch (e2) {
            // Final fallback - give up
          }
        });
      } else if (isQueueError) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (message.isNotEmpty) {
            try {
              _actuallyShowGetXSnackbar(message, type, color, duration);
            } catch (e2) {}
          }
        });
      } else {
        // Other error - retry once
        Future.delayed(const Duration(milliseconds: 200), () {
          if (message.isNotEmpty) {
            try {
              _actuallyShowGetXSnackbar(message, type, color, duration);
            } catch (e2) {
              // Give up
            }
          }
        });
      }
    }
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
