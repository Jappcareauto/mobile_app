import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/features/home/ui/home/widgets/dismiss_widget.dart';
import 'package:jappcare/features/notifications/ui/notifications/widgets/notification_item.dart';
import 'controllers/notifications_controller.dart';
import 'package:get/get.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Notifications",
        appBarcolor: Get.theme.scaffoldBackgroundColor,
        actions: [
          if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
            Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: 10,
            children: [
              if (controller.notifications.isNotEmpty) ...[
                Column(
                  spacing: 10,
                  children:
                      controller.notifications.asMap().entries.map((entry) {
                    final index = entry.key;
                    final notification = entry.value;

                    return Dismissible(
                      // key: Key(index.toString()),
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: const DismissWidget(),
                      onDismissed: (direction) {
                        // Action après la suppression
                        controller.notifications.removeAt(index);
                      },
                      child: NotificationItemWidget(
                        title: "Notification",
                        isRead: false,
                        description: notification,
                        date: "01-01-2025",
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
