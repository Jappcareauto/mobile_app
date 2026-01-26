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
    print("🔵🔵🔵 [showCustomSnackBar] FUNCTION CALLED!");
    print("🔵 [showCustomSnackBar] Message: '$message'");
    
    if (message.isEmpty) {
      print("🔴 [showCustomSnackBar] Message is empty, returning null");
      return null;
    }
    
    // Use ScaffoldMessenger as primary method - it's more reliable than GetX
    // GetX's queue system has validation issues that cause GetQueue._check errors
    _showWithScaffoldMessenger(message, type, color, duration);
    
    return null;
  }

  void _showWithScaffoldMessenger(
      String message,
      CustomSnackbarType type,
      Color? color,
      Duration? duration) {
    print("🟣 [_showWithScaffoldMessenger] Using ScaffoldMessenger");
    
    // Use post-frame callback to ensure widget tree is ready
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() {
        final context = Get.key.currentContext ?? Get.context;
        print("🟣 [_showWithScaffoldMessenger] Context: $context");
        
        if (context == null) {
          print("🔴 [_showWithScaffoldMessenger] No context, falling back to GetX");
          _showWithGetX(message, type, color, duration);
          return;
        }
        
        try {
          final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
          if (scaffoldMessenger != null) {
            print("✅ [_showWithScaffoldMessenger] ScaffoldMessenger found, showing snackbar");
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
                        style: TextStyle(color: AppColors.blackText, fontSize: 14),
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
                margin: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
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
            print("✅ [_showWithScaffoldMessenger] Snackbar shown successfully!");
          } else {
            print("🟡 [_showWithScaffoldMessenger] No ScaffoldMessenger, falling back to GetX");
            _showWithGetX(message, type, color, duration);
          }
        } catch (e) {
          print("❌ [_showWithScaffoldMessenger] Error: $e");
          print("🟡 [_showWithScaffoldMessenger] Falling back to GetX");
          _showWithGetX(message, type, color, duration);
        }
      });
    });
  }

  void _showWithGetX(
      String message,
      CustomSnackbarType type,
      Color? color,
      Duration? duration) {
    print("🟡 [_showWithGetX] Starting snackbar display process");
    print("🟡 [_showWithGetX] Message: '$message'");
    
    // Use post-frame callback to ensure GetX navigator is fully ready
    SchedulerBinding.instance.addPostFrameCallback((_) {
      print("🟡 [_showWithGetX] Post-frame callback executed");
      
      // Wait for next frame to ensure navigator is completely built
      Future.delayed(const Duration(milliseconds: 50), () {
        print("🟡 [_showWithGetX] After 50ms delay");
        
        if (message.isEmpty) {
          print("🔴 [_showWithGetX] Message is empty, returning");
          return;
        }
        
        // Verify navigator is ready before proceeding
        if (!_isNavigatorReady()) {
          print("🟡 [_showWithGetX] Navigator not ready, waiting 200ms more...");
          // Wait more if navigator not ready yet
          Future.delayed(const Duration(milliseconds: 200), () {
            if (message.isEmpty) {
              print("🔴 [_showWithGetX] Message is empty after delay, returning");
              return;
            }
            print("🟡 [_showWithGetX] Retrying after 200ms delay");
            _attemptShowSnackbar(message, type, color, duration);
          });
          return;
        }
        
        print("✅ [_showWithGetX] Navigator is ready, proceeding to show snackbar");
        _attemptShowSnackbar(message, type, color, duration);
      });
    });
  }

  void _attemptShowSnackbar(
      String message,
      CustomSnackbarType type,
      Color? color,
      Duration? duration) {
    print("🟢 [_attemptShowSnackbar] Attempting to show snackbar");
    print("🟢 [_attemptShowSnackbar] isSnackbarOpen: $isSnackbarOpen");
    
    // Don't close existing snackbars - let GetX handle queue management
    // Closing and immediately showing causes queue conflicts
    // Just wait a bit to ensure any ongoing operations complete
    print("🟢 [_attemptShowSnackbar] Waiting 400ms for any ongoing operations to complete...");
    
    // Wait for any ongoing queue operations to complete
    Future.delayed(const Duration(milliseconds: 400), () {
      print("🟢 [_attemptShowSnackbar] After 400ms delay, checking state...");
      
      if (message.isEmpty) {
        print("🔴 [_attemptShowSnackbar] Message is empty, returning");
        return;
      }
      
      // Verify navigator is ready before showing
      if (!_isNavigatorReady()) {
        print("🟡 [_attemptShowSnackbar] Navigator not ready, retrying after 500ms...");
        // Retry after more delay
        Future.delayed(const Duration(milliseconds: 500), () {
          if (message.isNotEmpty) {
            print("🟡 [_attemptShowSnackbar] Retry attempt after 500ms");
            _actuallyShowGetXSnackbar(message, type, color, duration);
          }
        });
        return;
      }
      
      print("✅ [_attemptShowSnackbar] Navigator is ready, showing snackbar");
      try {
        // Try to show the snackbar - let GetX handle queue management
        _actuallyShowGetXSnackbar(message, type, color, duration);
      } catch (e) {
        print("❌ [_attemptShowSnackbar] Error showing snackbar: $e");
        print("❌ [_attemptShowSnackbar] Error type: ${e.runtimeType}");
        print("❌ [_attemptShowSnackbar] Error stack: ${StackTrace.current}");
        
        // If it fails, wait a bit more and retry
        Future.delayed(const Duration(milliseconds: 300), () {
          if (message.isEmpty) {
            print("🔴 [_attemptShowSnackbar] Message is empty in retry, returning");
            return;
          }
          print("🟡 [_attemptShowSnackbar] Retrying after error...");
          try {
            _actuallyShowGetXSnackbar(message, type, color, duration);
          } catch (e2) {
            print("❌ [_attemptShowSnackbar] Retry also failed: $e2");
            // Final fallback - try one more time
            Future.delayed(const Duration(milliseconds: 500), () {
              if (message.isNotEmpty) {
                print("🟡 [_attemptShowSnackbar] Final retry attempt...");
                try {
                  _actuallyShowGetXSnackbar(message, type, color, duration);
                } catch (e3) {
                  print("🔴 [_attemptShowSnackbar] Final retry failed: $e3");
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
    print("🔍 [_isNavigatorReady] Navigator context: $navigatorContext");
    
    if (navigatorContext == null) {
      print("🔴 [_isNavigatorReady] No navigator context found!");
      return false;
    }
    
    // Check if we can access the Navigator
    try {
      Navigator.of(navigatorContext, rootNavigator: true);
      print("✅ [_isNavigatorReady] Navigator is ready");
      return true;
    } catch (e) {
      print("❌ [_isNavigatorReady] Navigator not ready: $e");
      return false;
    }
  }

  void _actuallyShowGetXSnackbar(
      String message,
      CustomSnackbarType type,
      Color? color,
      Duration? duration) {
    print("🟣 [_actuallyShowGetXSnackbar] Actually showing snackbar now");
    print("🟣 [_actuallyShowGetXSnackbar] Message: '$message'");
    
    if (message.isEmpty) {
      print("🔴 [_actuallyShowGetXSnackbar] Message is empty, returning");
      return;
    }
    
    // Verify navigator is ready
    if (!_isNavigatorReady()) {
      print("🟡 [_actuallyShowGetXSnackbar] Navigator not ready, waiting 150ms...");
      // Wait a bit and retry if navigator not ready
      Future.delayed(const Duration(milliseconds: 150), () {
        if (_isNavigatorReady() && message.isNotEmpty) {
          print("✅ [_actuallyShowGetXSnackbar] Retry found navigator, showing...");
          _actuallyShowGetXSnackbar(message, type, color, duration);
        } else {
          print("🔴 [_actuallyShowGetXSnackbar] Retry still no navigator");
        }
      });
      return;
    }
    
    print("✅ [_actuallyShowGetXSnackbar] Navigator is ready");
    print("🟣 [_actuallyShowGetXSnackbar] Get.context: ${Get.context}");
    print("🟣 [_actuallyShowGetXSnackbar] Get.key.currentContext: ${Get.key.currentContext}");
    
    try {
      print("🟣 [_actuallyShowGetXSnackbar] Calling Get.showSnackbar...");
      
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
      
      print("✅ [_actuallyShowGetXSnackbar] Get.showSnackbar called successfully!");
    } catch (e, stackTrace) {
      print("❌❌❌ [_actuallyShowGetXSnackbar] ERROR CAUGHT!");
      print("❌ Error type: ${e.runtimeType}");
      print("❌ Error message: $e");
      print("❌ Error toString: ${e.toString()}");
      print("❌ Stack trace: $stackTrace");
      
      // If Overlay error or any other error, retry after delay
      final errorString = e.toString();
      final isOverlayError = errorString.contains("Overlay") || 
                            errorString.contains("_Theater") ||
                            errorString.contains("No Overlay");
      final isQueueError = errorString.contains("queue") || 
                          errorString.contains("Queue") ||
                          errorString.contains("_check");
      
      print("🔍 [_actuallyShowGetXSnackbar] isOverlayError: $isOverlayError");
      print("🔍 [_actuallyShowGetXSnackbar] isQueueError: $isQueueError");
      
      if (isOverlayError) {
        print("🟡 [_actuallyShowGetXSnackbar] Overlay error detected, waiting 400ms...");
        // Wait longer and retry - navigator might not be ready
        Future.delayed(const Duration(milliseconds: 400), () {
          if (message.isEmpty) {
            print("🔴 [_actuallyShowGetXSnackbar] Message is empty in Overlay retry");
            return;
          }
          
          print("🟡 [_actuallyShowGetXSnackbar] Checking context again after Overlay error...");
          // Verify navigator is ready again
          if (!_isNavigatorReady()) {
            print("🟡 [_actuallyShowGetXSnackbar] Still no navigator, waiting 500ms more...");
            // Still no navigator, wait more
            Future.delayed(const Duration(milliseconds: 500), () {
              if (message.isNotEmpty) {
                print("🟡 [_actuallyShowGetXSnackbar] Final Overlay error retry...");
                _actuallyShowGetXSnackbar(message, type, color, duration);
              }
            });
            return;
          }
          
          print("✅ [_actuallyShowGetXSnackbar] Navigator found in retry, showing...");
          try {
            _actuallyShowGetXSnackbar(message, type, color, duration);
          } catch (e2) {
            print("🔴 [_actuallyShowGetXSnackbar] Retry also failed: $e2");
            // Final fallback - give up
          }
        });
      } else if (isQueueError) {
        print("🟡 [_actuallyShowGetXSnackbar] Queue error detected, waiting 300ms...");
        Future.delayed(const Duration(milliseconds: 300), () {
          if (message.isNotEmpty) {
            print("🟡 [_actuallyShowGetXSnackbar] Retrying after queue error...");
            try {
              _actuallyShowGetXSnackbar(message, type, color, duration);
            } catch (e2) {
              print("🔴 [_actuallyShowGetXSnackbar] Queue retry failed: $e2");
            }
          }
        });
      } else {
        print("🟡 [_actuallyShowGetXSnackbar] Other error, retrying after 200ms...");
        // Other error - retry once
        Future.delayed(const Duration(milliseconds: 200), () {
          if (message.isNotEmpty) {
            try {
              _actuallyShowGetXSnackbar(message, type, color, duration);
            } catch (e2) {
              print("🔴 [_actuallyShowGetXSnackbar] Other error retry failed: $e2");
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
