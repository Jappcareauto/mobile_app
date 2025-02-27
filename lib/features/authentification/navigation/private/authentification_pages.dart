import 'package:get/get.dart';

import '../bindings/reset_password_controller_binding.dart';
import '../../ui/resetPassword/reset_password_screen.dart';

import '../bindings/verify_your_email_controller_binding.dart';
import '../../ui/verifyYourEmail/verify_your_email_screen.dart';

import '../bindings/sign_up_with_phone_controller_binding.dart';
import '../../ui/signUpWithPhone/sign_up_with_phone_screen.dart';

import '../bindings/sign_up_with_email_controller_binding.dart';
import '../../ui/signUpWithEmail/sign_up_with_email_screen.dart';

import '../bindings/login_with_phone_controller_binding.dart';
import '../../ui/loginWithPhone/login_with_phone_screen.dart';

import '../bindings/login_with_email_controller_binding.dart';
import '../../ui/loginWithEmail/login_with_email_screen.dart';

import '../../../../core/navigation/routes/features_pages.dart';
import '../../ui/authentification/authentification_screen.dart';
import '../bindings/authentification_controller_binding.dart';
import 'authentification_private_routes.dart';

class AuthentificationPages implements FeaturePages {
  @override
  List<GetPage>  getPages() => [
    GetPage(
      name: AuthentificationPrivateRoutes.home,
      page: () => const AuthentificationScreen(),
      binding: AuthentificationControllerBinding(),
    ),
    
    GetPage(
      name: AuthentificationPrivateRoutes.loginWithEmail,
      page: () => const LoginWithEmailScreen(),
      binding: LoginWithEmailControllerBinding(),
    ),
    GetPage(
      name: AuthentificationPrivateRoutes.loginWithPhone,
      page: () => const LoginWithPhoneScreen(),
      binding: LoginWithPhoneControllerBinding(),
    ),
    GetPage(
      name: AuthentificationPrivateRoutes.signUpWithEmail,
      page: () => const SignUpWithEmailScreen(),
      binding: SignUpWithEmailControllerBinding(),
    ),
    GetPage(
      name: AuthentificationPrivateRoutes.signUpWithPhone,
      page: () => const SignUpWithPhoneScreen(),
      binding: SignUpWithPhoneControllerBinding(),
    ),
    GetPage(
      name: AuthentificationPrivateRoutes.verifyYourEmail,
      page: () => const VerifyYourEmailScreen(),
      binding: VerifyYourEmailControllerBinding(),
    ),
    GetPage(
      name: AuthentificationPrivateRoutes.resetPassword,
      page: () => const ResetPasswordScreen(),
      binding: ResetPasswordControllerBinding(),
    ),
    // Add other routes here
  ];
}