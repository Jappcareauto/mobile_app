import 'package:get/get.dart';
import '../../../../../core/navigation/app_navigation.dart';

class PrivacyPolicyController extends GetxController {
  final AppNavigation _appNavigation;
  PrivacyPolicyController(this._appNavigation);

  final textData = """
The information you provided during the registration process does not currently meet our profile criteria. We appreciate your time and interest in teaching with us. You're always welcome to apply again in the future.

The information you provided during the registration process does not currently meet our profile criteria. We appreciate your time and interest in teaching with us. You're always welcome to apply again in the future. The information you provided during the registration process does not currently meet our profile criteria. We appreciate your time and interest in teaching with us. You're always welcome to apply again in the future.

The information you provided during the registration process does not currently meet our profile criteria. We appreciate your time and interest in teaching with us. You're always welcome to apply again in the future.
""";

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack() {
    _appNavigation.goBack();
  }
}
