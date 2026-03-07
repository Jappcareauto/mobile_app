import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_dimensions.dart';
import 'package:jappcare/generated/locales.g.dart';
import 'controllers/privacy_policy_controller.dart';

class PrivacyPolicyScreen extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.privacy_policy.tr,
        canBack: true,
        appBarcolor: Get.theme.scaffoldBackgroundColor,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        ),
        children: [
          // Header — last updated
          Text(
            LocaleKeys.pp_last_updated.tr,
            style: textTheme.bodySmall?.copyWith(color: AppColors.greyText),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),

          // Sections
          ...controller.sections.map((section) => _SectionWidget(
                section: section,
                textTheme: textTheme,
              )),

          // Contact block
          _ContactBlock(textTheme: textTheme),

          const SizedBox(height: AppDimensions.paddingExtraLarge),
        ],
      ),
    );
  }
}

class _SectionWidget extends StatelessWidget {
  final PolicySection section;
  final TextTheme textTheme;

  const _SectionWidget({
    required this.section,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: textTheme.titleSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          if (section.body != null)
            Text(
              section.body!,
              style: textTheme.bodyMedium
                  ?.copyWith(color: AppColors.blackText, height: 1.6),
            ),
          if (section.subsections.isNotEmpty) ...[
            const SizedBox(height: 4),
            ...section.subsections.map(
              (sub) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sub.subtitle,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 6, right: 8),
                          child: Icon(
                            Icons.circle,
                            size: 6,
                            color: AppColors.greyText,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            sub.body,
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.blackText,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          Divider(color: AppColors.lightBorder, height: 1),
        ],
      ),
    );
  }
}

class _ContactBlock extends StatelessWidget {
  final TextTheme textTheme;

  const _ContactBlock({required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppDimensions.paddingSmall),
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.business_rounded,
                  color: AppColors.primary, size: 18),
              const SizedBox(width: 8),
              Text(
                LocaleKeys.pp_company.tr,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_outlined,
                  color: AppColors.greyText, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  LocaleKeys.pp_address.tr,
                  style: textTheme.bodySmall
                      ?.copyWith(color: AppColors.greyText, height: 1.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.email_outlined,
                  color: AppColors.greyText, size: 16),
              const SizedBox(width: 8),
              Text(
                LocaleKeys.pp_email.tr,
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
