import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/features/notifications/ui/notifications/widgets/notification_item.dart';
import 'controllers/notifications_controller.dart';
import 'package:get/get.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Notifications"),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              for (var i = 0; i < 20; i++)
                const NotificationItemWidget(
                    title: "Notification",
                    description:
                        "Your repair from the Japcare Autotech shop is ready, and available for pickup"),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
