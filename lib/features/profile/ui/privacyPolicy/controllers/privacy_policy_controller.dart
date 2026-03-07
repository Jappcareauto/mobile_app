import 'package:get/get.dart';
import 'package:jappcare/generated/locales.g.dart';
import '../../../../../core/navigation/app_navigation.dart';

class PolicySubsection {
  final String subtitle;
  final String body;

  const PolicySubsection({required this.subtitle, required this.body});
}

class PolicySection {
  final String title;
  final String? body;
  final List<PolicySubsection> subsections;

  const PolicySection({
    required this.title,
    this.body,
    this.subsections = const [],
  });
}

class PrivacyPolicyController extends GetxController {
  final AppNavigation _appNavigation;
  PrivacyPolicyController(this._appNavigation);

  List<PolicySection> get sections => [
        PolicySection(
          title: LocaleKeys.pp_s1_title.tr,
          subsections: [
            PolicySubsection(
              subtitle: LocaleKeys.pp_s1_account_sub.tr,
              body: LocaleKeys.pp_s1_account_body.tr,
            ),
            PolicySubsection(
              subtitle: LocaleKeys.pp_s1_location_sub.tr,
              body: LocaleKeys.pp_s1_location_body.tr,
            ),
            PolicySubsection(
              subtitle: LocaleKeys.pp_s1_usage_sub.tr,
              body: LocaleKeys.pp_s1_usage_body.tr,
            ),
          ],
        ),
        PolicySection(
          title: LocaleKeys.pp_s2_title.tr,
          body: LocaleKeys.pp_s2_body.tr,
        ),
        PolicySection(
          title: LocaleKeys.pp_s3_title.tr,
          body: LocaleKeys.pp_s3_body.tr,
        ),
        PolicySection(
          title: LocaleKeys.pp_s4_title.tr,
          body: LocaleKeys.pp_s4_body.tr,
        ),
        PolicySection(
          title: LocaleKeys.pp_s5_title.tr,
          body: LocaleKeys.pp_s5_body.tr,
        ),
        PolicySection(
          title: LocaleKeys.pp_s6_title.tr,
          body: LocaleKeys.pp_s6_body.tr,
        ),
        PolicySection(
          title: LocaleKeys.pp_s7_title.tr,
          body: LocaleKeys.pp_s7_body.tr,
        ),
        PolicySection(
          title: LocaleKeys.pp_s8_title.tr,
          body: LocaleKeys.pp_s8_body.tr,
        ),
        PolicySection(
          title: LocaleKeys.pp_s9_title.tr,
          body: LocaleKeys.pp_s9_body.tr,
        ),
      ];

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack() {
    _appNavigation.goBack();
  }
}
