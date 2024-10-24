import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/ui/widgets/app_bar_with_salutation.dart';
import 'package:jappcare/features/home/ui/home/widgets/service_widget.dart';
import 'package:jappcare/features/home/ui/home/widgets/title_section.dart';
import '../../../../core/utils/app_images.dart';
import 'controllers/home_controller.dart';
import 'widgets/notification_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController(Get.find()));
    return Scaffold(
      appBar: const AppBarWithAvatarAndSalutation(
        greetingMessage: 'Good Morning'
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ImageComponent(
                      imageUrl: "https://www.gstatic.com/webp/gallery/2.jpg",
                      width: Get.width,
                      borderRadius: 20,
                      height: 160),
                  const SizedBox(height: 30),
                  NotificationWidget(
                    title: "Notification",
                    bodyText:
                        'Your repair from the Japcare Autotech shop is ready, and available for pickup',
                    coloriage: Get.theme.primaryColor,
                    icon: FluentIcons.alert_16_filled,
                  ),
                  NotificationWidget(
                    title: "Tip",
                    bodyText:
                        'Rotate your tires regulary to ensure they wear evenly and last longer.',
                    coloriage: Get.theme.colorScheme.secondary,
                    icon: FluentIcons.question_16_filled,
                    onTap: controller.openTipModal,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (Get.isRegistered<FeatureWidgetInterface>(
                tag: 'ListVehicleWidget'))
              Get.find<FeatureWidgetInterface>(tag: 'ListVehicleWidget')
                  .buildView(),
            const SizedBox(height: 20),
            if (Get.isRegistered<FeatureWidgetInterface>(
                tag: 'RecentActivitiesWidget'))
              Get.find<FeatureWidgetInterface>(tag: 'RecentActivitiesWidget')
                  .buildView({
                'haveTabBar': false,
                'haveTitle': true,
                'title': 'Upcoming Activities',
                'status': 'Completed',
                'isHorizontal': true
              }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const TitleSection(nameSection: 'Services'),
                  Row(
                    children: [
                      Expanded(
                        child: CustomCardService(
                          color: Color(0xFFF4EEFF),
                          text: 'VIN\nLookup',
                          imagePath: AppImages.vin,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomCardService(
                          color: Color(0xFFFFEDE6),
                          text: 'Service\nLocator',
                          imagePath: AppImages.service,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomCardService(
                          color: Color(0xFFC4FFCD),
                          text: 'Vehicles\nReports',
                          imagePath: AppImages.vehicule,
                          onTap: controller.goToVehicleReport,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomCardService(
                          color: Color(0xFFFFDAD4),
                          text: 'Emergency\nAssistance',
                          imagePath: AppImages.emergency,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //RecentActivitiesWidget
            if (Get.isRegistered<FeatureWidgetInterface>(
                tag: 'RecentActivitiesWidget'))
              Get.find<FeatureWidgetInterface>(tag: 'RecentActivitiesWidget')
                  .buildView(),
          ],
        ),
      ),
    );
  }
}
