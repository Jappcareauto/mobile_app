import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/features/authentification/ui/authentification/authentification_screen.dart';

import '../domain/repositories/authentification_repository.dart';
import '../infrastructure/repositoriesImpl/authentification_repository_impl.dart';

import '../application/usecases/login_usecase.dart';

import '../application/usecases/register_usecase.dart';

import '../application/usecases/verify_email_usecase.dart';

import '../application/usecases/resend_otp_usecase.dart';

class AuthentificationDependencies {
  static void init() {
    Get.lazyPut<AuthentificationRepository>(() => AuthentificationRepositoryImpl(
        networkService: Get.find()), fenix: true);

    Get.lazyPut<FeatureWidgetInterface>(() => AuthentificationScreen(),
        tag: 'AuthentificationScreen', fenix: true);
      Get.lazyPut(() => LoginUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => RegisterUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => VerifyEmailUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => ResendOtpUseCase(Get.find()), fenix: true);
}
}
