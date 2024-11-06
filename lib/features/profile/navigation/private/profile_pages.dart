import 'package:get/get.dart';

import '../bindings/payments_controller_binding.dart';
import '../../ui/payments/payments_screen.dart';

import '../bindings/history_controller_binding.dart';
import '../../ui/history/history_screen.dart';

import '../bindings/privacy_policy_controller_binding.dart';
import '../../ui/privacyPolicy/privacy_policy_screen.dart';

import '../bindings/terms_and_conditions_controller_binding.dart';
import '../../ui/termsAndConditions/terms_and_conditions_screen.dart';

import '../bindings/edit_profile_controller_binding.dart';
import '../../ui/editProfile/edit_profile_screen.dart';

import '../bindings/settings_controller_binding.dart';
import '../../ui/settings/settings_screen.dart';
import '../../../../core/navigation/routes/features_pages.dart';
import '../../ui/profile/profile_screen.dart';
import '../bindings/profile_controller_binding.dart';
import 'profile_private_routes.dart';

class ProfilePages implements FeaturePages {
  @override
  List<GetPage>  getPages() => [
    GetPage(
      name: ProfilePrivateRoutes.home,
      page: () => ProfileScreen(),
      binding: ProfileControllerBinding(),
    ),
    GetPage(
      name: ProfilePrivateRoutes.settings,
      page: () => SettingsScreen(),
      binding: SettingsControllerBinding(),
    ),
    GetPage(
      name: ProfilePrivateRoutes.editProfile,
      page: () => EditProfileScreen(),
      binding: EditProfileControllerBinding(),
    ),
    GetPage(
      name: ProfilePrivateRoutes.termsAndConditions,
      page: () => TermsAndConditionsScreen(),
      binding: TermsAndConditionsControllerBinding(),
    ),
    GetPage(
      name: ProfilePrivateRoutes.privacyPolicy,
      page: () => PrivacyPolicyScreen(),
      binding: PrivacyPolicyControllerBinding(),
    ),
    GetPage(
      name: ProfilePrivateRoutes.history,
      page: () => HistoryScreen(),
      binding: HistoryControllerBinding(),
    ),
    GetPage(
      name: ProfilePrivateRoutes.payments,
      page: () => PaymentsScreen(),
      binding: PaymentsControllerBinding(),
    ),
    // Add other routes here
  ];
}
