import 'package:get/get.dart';

import '../bindings/notification_details_controller_binding.dart';
import '../../ui/notificationDetails/notification_details_screen.dart';
import '../../../../core/navigation/routes/features_pages.dart';
import '../../ui/notifications/notifications_screen.dart';
import '../bindings/notifications_controller_binding.dart';
import 'notifications_private_routes.dart';

class NotificationsPages implements FeaturePages {
  @override
  List<GetPage>  getPages() => [
    GetPage(
      name: NotificationsPrivateRoutes.home,
      page: () => NotificationsScreen(),
      binding: NotificationsControllerBinding(),
    ),
    GetPage(
      name: NotificationsPrivateRoutes.notificationDetails,
      page: () => NotificationDetailsScreen(),
      binding: NotificationDetailsControllerBinding(),
    ),
    // Add other routes here
  ];
}
