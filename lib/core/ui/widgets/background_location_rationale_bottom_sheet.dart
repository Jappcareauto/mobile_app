// ============================================================================
// BackgroundLocationRationaleBottomSheet
// ============================================================================
// Android 11+ (API 30+) REQUIRES apps to present a separate, clearly-worded
// rationale screen BEFORE requesting ACCESS_BACKGROUND_LOCATION.
//
// Google Play will REJECT apps that:
//   ✗  Request ACCESS_BACKGROUND_LOCATION without a separate disclosure.
//   ✗  Show a generic alert that doesn't explicitly name background access.
//   ✗  Request background and foreground permissions in the same dialog.
//
// This bottom sheet fulfils the requirement by:
//   ✅  Being a separate, dedicated screen (not combined with foreground ask).
//   ✅  Explicitly naming "background" / "when app is closed or not in use".
//   ✅  Clearly stating WHICH features require background access.
//   ✅  Not being dismissible without an explicit user choice.
//   ✅  Following the app's design system.
// ============================================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_dimensions.dart';
import 'package:jappcare/generated/locales.g.dart';

class BackgroundLocationRationaleBottomSheet extends StatelessWidget {
  const BackgroundLocationRationaleBottomSheet({super.key});

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

            // ── Illustration ───────────────────────────────────────────────
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Icon(
                    Icons.location_searching_rounded,
                    color: AppColors.primary,
                    size: 40,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),

            // ── Title ──────────────────────────────────────────────────────
            Center(
              child: Text(
                LocaleKeys.loc_bg_title.tr,
                style: textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackText,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingExtraSmall),

            // ── MANDATORY: Explicit background access statement ────────────
            // The phrasing "even when the app is closed or not in use" is the
            // exact language mandated by Google Play policy for background
            // location disclosure.
            Center(
              child: Text(
                LocaleKeys.loc_bg_subtitle.tr,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.greyText,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),

            // ── Reason tiles ───────────────────────────────────────────────
            _ReasonTile(
              icon: Icons.emergency_rounded,
              color: AppColors.red,
              background: const Color(0xFFFFEBEE),
              text: LocaleKeys.loc_bg_emergency_text.tr,
            ),
            const SizedBox(height: AppDimensions.paddingExtraSmall),
            _ReasonTile(
              icon: Icons.route_rounded,
              color: AppColors.orange,
              background: AppColors.secondary,
              text: LocaleKeys.loc_bg_roadside_text.tr,
            ),

            const SizedBox(height: AppDimensions.paddingMedium),

            // ── System settings note ───────────────────────────────────────
            // On Android 11+, the OS automatically sends the user to the
            // system settings screen; we must tell the user what to tap.
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingSmall),
              decoration: BoxDecoration(
                color: AppColors.lightSurface,
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusMedium),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.settings_outlined,
                    color: AppColors.greyText,
                    size: 18,
                  ),
                  const SizedBox(width: AppDimensions.paddingExtraSmall),
                  Expanded(
                    child: Text(
                      LocaleKeys.loc_bg_settings_note.tr,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.greyText,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.paddingExtraLarge),

            // ── CTA: Allow ─────────────────────────────────────────────────
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
                  LocaleKeys.loc_bg_accept.tr,
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),

            // ── CTA: Skip (foreground-only) ────────────────────────────────
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
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  LocaleKeys.loc_bg_decline.tr,
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

class _ReasonTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;
  final String text;

  const _ReasonTile({
    required this.icon,
    required this.color,
    required this.background,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: background,
            borderRadius:
                BorderRadius.circular(AppDimensions.radiusExtraSmall + 2),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: AppDimensions.paddingExtraSmall),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              text,
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.greyText,
                height: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
