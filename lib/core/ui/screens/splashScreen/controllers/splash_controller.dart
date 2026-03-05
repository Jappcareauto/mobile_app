import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/navigation/routes/app_routes.dart';
import 'package:jappcare/core/services/location/location_permission_service.dart';
import '../../../../navigation/app_navigation.dart';

class SplashController extends GetxController {
  final AppNavigation _appNavigation;
  SplashController(this._appNavigation);

  @override
  void onInit() {
    super.onInit();
    _navigateToNextPage();
  }

  Future<void> _navigateToNextPage() async {
    // Minimum splash display time so the brand animation is visible.
    await Future.delayed(const Duration(seconds: 3));

    // ── Google Play Prominent Disclosure flow ────────────────────────────
    // We run the permission flow during splash so that:
    //   1. The user sees the branded disclosure (not a cold OS dialog).
    //   2. The flow completes before any location-dependent screen opens.
    //   3. If the user has already consented in a previous session and the
    //      OS permission is still granted, this completes instantly.
    //
    // The flow is:
    //   a) Show Prominent Disclosure bottom sheet (first launch only).
    //   b) Request ACCESS_FINE_LOCATION / ACCESS_COARSE_LOCATION.
    //   c) Show background-location rationale bottom sheet.
    //   d) Request ACCESS_BACKGROUND_LOCATION (routed to system settings
    //      on Android 11+).
    //
    // The outcome does NOT block navigation – the app works with any
    // combination of granted / denied permissions. Features that need
    // location show a localised placeholder when permission is absent.
    // Only run the full permission flow on first launch (i.e. user has
    // never seen the disclosure). On subsequent launches the disclosure
    // consent is already persisted and the OS permission is retained, so
    // we skip to avoid showing popups every time the app opens.
    final locationService = LocationPermissionService.instance;
    if (!locationService.hasSeenDisclosure) {
      final BuildContext? context = Get.context;
      if (context != null && context.mounted) {
        await locationService.requestLocationPermissions(context);
      }
    }

    _appNavigation.toNamedAndReplaceAll(AppRoutes.home);
  }
}
