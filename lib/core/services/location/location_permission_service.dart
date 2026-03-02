// ============================================================================
// LocationPermissionService
// ============================================================================
// Google Play User Data Policy requires a "Prominent Disclosure" that is
// shown to the user BEFORE any location permission is requested.
//
// This service enforces the following compliant flow:
//   1. Check whether the user has already seen the disclosure + consented
//      (stored locally so the disclosure never re-appears after first consent).
//   2. If not yet seen → show the Prominent Disclosure bottom sheet.
//   3. On user acceptance → request foreground location
//      (ACCESS_FINE_LOCATION / ACCESS_COARSE_LOCATION).
//   4. Once foreground is granted → show the background-location rationale
//      bottom sheet (mandatory on Android 11+ before requesting
//      ACCESS_BACKGROUND_LOCATION).
//   5. On acceptance → request background location.
//   6. Handle denial at every step gracefully.
//
// References:
//   • https://support.google.com/googleplay/android-developer/answer/9799150
//   • https://developer.android.com/training/location/permissions
// ============================================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/app_constants.dart';
import '../../../core/ui/widgets/location_disclosure_bottom_sheet.dart';
import '../../../core/ui/widgets/background_location_rationale_bottom_sheet.dart';
import '../../../generated/locales.g.dart';

/// Outcome of the entire permission flow.
enum LocationPermissionOutcome {
  /// User declined to view or accept the disclosure.
  disclosureDeclined,

  /// Foreground location granted (background not yet requested).
  foregroundOnly,

  /// Both foreground and background location granted.
  foregroundAndBackground,

  /// Foreground location denied (permanently or by refusal).
  foregroundDenied,

  /// Background location denied (permanently or by refusal).
  backgroundDenied,
}

class LocationPermissionService {
  LocationPermissionService._();

  static final LocationPermissionService instance =
      LocationPermissionService._();

  final GetStorage _storage = GetStorage();

  // ─── Public API ──────────────────────────────────────────────────────────

  /// Returns true if the user has previously consented to the disclosure.
  ///
  /// Use this to decide whether to show a "location disabled" placeholder
  /// or silently skip requesting permissions when they are already granted.
  bool get hasSeenDisclosure =>
      _storage.read<bool>(AppConstants.locationDisclosureConsentKey) ?? false;

  /// Returns true if foreground location is currently granted.
  Future<bool> get isForegroundGranted async =>
      await Permission.locationWhenInUse.isGranted;

  /// Returns true if background location is currently granted.
  Future<bool> get isBackgroundGranted async =>
      await Permission.locationAlways.isGranted;

  // ─── Main entry point ────────────────────────────────────────────────────

  /// Run the full Google-Play–compliant permission flow.
  ///
  /// Call this from your screen/controller BEFORE using any location API.
  ///
  /// [context] – the current BuildContext (needed for bottom sheets).
  ///
  /// Returns a [LocationPermissionOutcome] describing what was granted.
  Future<LocationPermissionOutcome> requestLocationPermissions(
    BuildContext context,
  ) async {
    // ── Step 1: Show Prominent Disclosure if the user has not yet seen it ──
    // IMPORTANT: This check must come BEFORE the "already granted" early-
    // return so that new accounts on a device where another account already
    // granted location still go through the disclosure flow.
    // Google Play REQUIRES the disclosure to be shown BEFORE the OS dialog.
    if (!hasSeenDisclosure) {
      final bool accepted = await _showProminentDisclosure(context);
      if (!accepted) {
        // User dismissed / declined – never ask for location.
        return LocationPermissionOutcome.disclosureDeclined;
      }
      // Persist that the user has accepted the disclosure so we never
      // show it again for this account (but we will still check runtime
      // permission status).
      await _storage.write(
        AppConstants.locationDisclosureConsentKey,
        true,
      );
    }

    // ── Step 0 (after disclosure): If the OS already granted background
    //           location there is nothing more to request. ─────────────────
    if (await Permission.locationAlways.isGranted) {
      return LocationPermissionOutcome.foregroundAndBackground;
    }

    // ── Step 2: Request FOREGROUND location ────────────────────────────────
    // On Android 11+, the OS ONLY allows requesting foreground location
    // (FINE / COARSE) in this first step.  Background must come separately.
    final PermissionStatus foregroundStatus =
        await Permission.locationWhenInUse.request();

    if (!foregroundStatus.isGranted) {
      if (foregroundStatus.isPermanentlyDenied) {
        _showPermanentlyDeniedSnackbar(isBackground: false);
      }
      return LocationPermissionOutcome.foregroundDenied;
    }

    // ── Step 3: Show background-location rationale BEFORE the OS dialog ───
    // Google Play explicitly requires a separate prominent disclosure for
    // ACCESS_BACKGROUND_LOCATION that clearly states the app will collect
    // location even when the app is closed or not in use.
    final bool backgroundAccepted =
        await _showBackgroundLocationRationale(context);
    if (!backgroundAccepted) {
      // User chose to proceed with foreground-only location.
      return LocationPermissionOutcome.foregroundOnly;
    }

    // ── Step 4: Request BACKGROUND location ───────────────────────────────
    // permission_handler routes to the OS settings page on Android 11+
    // because the OS no longer allows runtime-requesting locationAlways
    // directly – it must be granted via the "Allow all the time" option in
    // system settings.
    final PermissionStatus backgroundStatus =
        await Permission.locationAlways.request();

    if (!backgroundStatus.isGranted) {
      if (backgroundStatus.isPermanentlyDenied) {
        _showPermanentlyDeniedSnackbar(isBackground: true);
      }
      return LocationPermissionOutcome.backgroundDenied;
    }

    return LocationPermissionOutcome.foregroundAndBackground;
  }

  // ─── Private helpers ─────────────────────────────────────────────────────

  /// Shows the Prominent Disclosure bottom sheet.
  /// Returns true if the user accepted, false if dismissed.
  Future<bool> _showProminentDisclosure(BuildContext context) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      // Prevent dismissal by tapping outside – the user must make an explicit
      // choice (required by Google Play policy).
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const LocationDisclosureBottomSheet(),
    );
    return result ?? false;
  }

  /// Shows the background-location rationale bottom sheet.
  /// Returns true if the user accepted, false if declined.
  Future<bool> _showBackgroundLocationRationale(BuildContext context) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const BackgroundLocationRationaleBottomSheet(),
    );
    return result ?? false;
  }

  /// Shows a GetX snackbar when a permission has been permanently denied,
  /// prompting the user to open system settings.
  void _showPermanentlyDeniedSnackbar({required bool isBackground}) {
    Get.snackbar(
      isBackground
          ? LocaleKeys.loc_bg_denied_title.tr
          : LocaleKeys.location_permission_denied.tr,
      isBackground
          ? LocaleKeys.loc_bg_denied_message.tr
          : LocaleKeys.loc_fg_denied_message.tr,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 6),
      mainButton: TextButton(
        onPressed: () async {
          Get.back(); // close snackbar
          await openAppSettings();
        },
        child: Text(
          LocaleKeys.settings.tr,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
