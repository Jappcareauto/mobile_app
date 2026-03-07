import 'package:get/get.dart';
import 'package:jappcare/generated/locales.g.dart';
import '../../../../../core/navigation/app_navigation.dart';

class TermsAndConditionsController extends GetxController {
  final AppNavigation _appNavigation;
  TermsAndConditionsController(this._appNavigation);

  @override
  void onInit() {
    super.onInit();
  }

  void goBack() {
    _appNavigation.goBack();
  }

  List<Map<String, String>> get sections => [
        {'title': LocaleKeys.tc_s1_title.tr, 'body': LocaleKeys.tc_s1_body.tr},
        {'title': LocaleKeys.tc_s2_title.tr, 'body': LocaleKeys.tc_s2_body.tr},
        {'title': LocaleKeys.tc_s3_title.tr, 'body': LocaleKeys.tc_s3_body.tr},
        {'title': LocaleKeys.tc_s4_title.tr, 'body': LocaleKeys.tc_s4_body.tr},
        {'title': LocaleKeys.tc_s5_title.tr, 'body': LocaleKeys.tc_s5_body.tr},
        {'title': LocaleKeys.tc_s6_title.tr, 'body': LocaleKeys.tc_s6_body.tr},
        {'title': LocaleKeys.tc_s7_title.tr, 'body': LocaleKeys.tc_s7_body.tr},
        {'title': LocaleKeys.tc_s8_title.tr, 'body': LocaleKeys.tc_s8_body.tr},
        {'title': LocaleKeys.tc_s9_title.tr, 'body': LocaleKeys.tc_s9_body.tr},
        {
          'title': LocaleKeys.tc_s10_title.tr,
          'body': LocaleKeys.tc_s10_body.tr
        },
        {
          'title': LocaleKeys.tc_s11_title.tr,
          'body': LocaleKeys.tc_s11_body.tr
        },
        {
          'title': LocaleKeys.tc_s12_title.tr,
          'body': LocaleKeys.tc_s12_body.tr
        },
        {
          'title': LocaleKeys.tc_s13_title.tr,
          'body': LocaleKeys.tc_s13_body.tr
        },
      ];

  String get lastUpdated => LocaleKeys.tc_last_updated.tr;
}
