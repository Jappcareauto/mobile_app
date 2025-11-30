import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/features/error/navigation/private/error_private_routes.dart';

/// Global connectivity controller that listens to connectivity changes
/// and navigates to the network error screen when offline.
class ConnectivityController extends GetxController {
  final AppNavigation _appNavigation;
  late final StreamSubscription<List<ConnectivityResult>?> _sub;

  ConnectivityController(this._appNavigation);

  @override
  void onInit() {
    super.onInit();
    // start listening
    _sub = Connectivity().onConnectivityChanged.listen(_onConnectivityChanged);

    // also check initial connectivity
    Connectivity().checkConnectivity().then(_onConnectivityChanged);
  }

  void _onConnectivityChanged(List<ConnectivityResult>? result) {
    final isOnline = !(result?.contains(ConnectivityResult.none) ?? false);

    final current = Get.currentRoute;

    if (!isOnline) {
      // If not already on the network error screen, navigate to it
      if (current != ErrorPrivateRoutes.networkError) {
        _appNavigation.toNamed(ErrorPrivateRoutes.networkError);
      }
    } else {
      // If we are on the network error screen, go back
      if (current == ErrorPrivateRoutes.networkError) {
        try {
          _appNavigation.goBack();
        } catch (_) {}
      }
    }
  }

  @override
  void onClose() {
    _sub.cancel();
    super.onClose();
  }
}
