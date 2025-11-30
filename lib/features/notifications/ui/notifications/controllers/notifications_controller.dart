import 'package:get/get.dart';
import '../../../../../core/navigation/app_navigation.dart';

class NotificationsController extends GetxController {
  final AppNavigation _appNavigation;
  NotificationsController(this._appNavigation);

  List<String> notifications = [
    "Your repair from the Jappcare Autotech shop is ready, and available for pickup.",
    "You have a new message from John Doe. Tap to read.",
    "Your order has shipped! Track your package now.",
    "Don't forget: Meeting at 2 PM today. Tap for details.",
    "Limited time offer! Get 20% off your next purchase.",
    "Congratulations! You've won a free gift.",
    "New version available! Update now to get the latest features.",
    "Your payment is due today. Tap to pay now and avoid late fees."
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
