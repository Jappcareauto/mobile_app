// ============================================================================
// LocationDisclosureBottomSheet
// ============================================================================
// Google Play USER DATA POLICY – Prominent Disclosure requirement:
//
//   "If your app accesses location in the background, you must provide an
//    in-app disclosure BEFORE the runtime permission prompt that clearly
//    explains what data is collected, how it is used, and whether it is
//    shared with third parties."
//
// This bottom sheet fulfils that requirement.  Key rules satisfied:
//   ✅  Shown BEFORE any OS permission dialog.
//   ✅  Clearly identifies the type of data (precise location).
//   ✅  Explicitly states the app accesses location when closed / not in use.
//   ✅  States the purpose (emergency services, service-center locator, etc.).
//   ✅  Not dismissible without an explicit user action (isDismissible: false).
//   ✅  Uses the app's own design language (branded, not a generic alert).
// ============================================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_dimensions.dart';
import 'package:jappcare/generated/locales.g.dart';

class LocationDisclosureBottomSheet extends StatelessWidget {
  const LocationDisclosureBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppDimensions.paddingLarge,
          AppDimensions.paddingLarge,
          AppDimensions.paddingLarge,
          AppDimensions.paddingExtraLarge,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Drag handle ────────────────────────────────────────────────
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.lightBorder,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusExtraSmall),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingLarge),

            // ── Icon + title ───────────────────────────────────────────────
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusMedium),
                  ),
                  child: const Icon(
                    Icons.location_on_rounded,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingSmall),
                Expanded(
                  child: Text(
                    // Google Play requires the disclosure to clearly name the
                    // data type in the title or first sentence.
                    LocaleKeys.loc_disclosure_title.tr,
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackText,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingMedium),

            // ── Prominent Disclosure text ──────────────────────────────────
            // Google Play requires the disclosure to be "prominent" – meaning
            // it must be clearly readable and not buried in a privacy policy.
            Text(
              LocaleKeys.loc_disclosure_how_we_use.tr,
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.blackText,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingExtraSmall),
            Text(
              LocaleKeys.loc_disclosure_intro.tr,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.greyText,
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),

            // ── Feature list ───────────────────────────────────────────────
            _FeatureTile(
              icon: Icons.local_hospital_rounded,
              iconColor: AppColors.red,
              iconBackground: const Color(0xFFFFEBEE),
              title: LocaleKeys.loc_disclosure_emergency_title.tr,
              description: LocaleKeys.loc_disclosure_emergency_desc.tr,
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            _FeatureTile(
              icon: Icons.build_circle_rounded,
              iconColor: AppColors.orange,
              iconBackground: AppColors.secondary,
              title: LocaleKeys.loc_disclosure_workshop_title.tr,
              description: LocaleKeys.loc_disclosure_workshop_desc.tr,
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            _FeatureTile(
              icon: Icons.directions_car_rounded,
              iconColor: AppColors.purple,
              iconBackground: const Color(0xFFEDE7F6),
              title: LocaleKeys.loc_disclosure_vehicle_title.tr,
              description: LocaleKeys.loc_disclosure_vehicle_desc.tr,
            ),

            const SizedBox(height: AppDimensions.paddingMedium),

            // ── MANDATORY: Background access statement ─────────────────────
            // Google Play REQUIRES an explicit statement that location is
            // accessed when the app is closed / not in use.
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingSmall),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusMedium),
                border: Border.all(color: AppColors.peach),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: AppDimensions.paddingExtraSmall),
                  Expanded(
                    child: Text(
                      // ⚠️  This sentence is the exact language Google Play
                      // reviews look for.  Do NOT remove or reword it.
                      LocaleKeys.loc_disclosure_background_notice.tr,
                      style: textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFE65100),
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.paddingSmall),

            // ── Privacy policy reference ───────────────────────────────────
            Text(
              LocaleKeys.loc_disclosure_privacy.tr,
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.greyText,
                height: 1.5,
              ),
            ),

            const SizedBox(height: AppDimensions.paddingExtraLarge),

            // ── Action buttons ─────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusSmall),
                  ),
                  elevation: 0,
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  LocaleKeys.loc_disclosure_accept.tr,
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.greyText,
                  side: const BorderSide(color: AppColors.lightBorder),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusSmall),
                  ),
                ),
                // Returning false signals the service that the user declined.
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  LocaleKeys.loc_disclosure_decline.tr,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.greyText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Internal helper widget ───────────────────────────────────────────────────

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String description;

  const _FeatureTile({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: iconBackground,
            borderRadius:
                BorderRadius.circular(AppDimensions.radiusExtraSmall + 2),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: AppDimensions.paddingExtraSmall),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.greyText,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
