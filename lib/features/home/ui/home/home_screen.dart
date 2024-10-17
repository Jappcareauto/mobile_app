import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/home/ui/home/widgets/app_bar_with_salutation.dart';
import 'package:jappcare/features/home/ui/home/widgets/service_widget.dart';
import 'package:jappcare/features/home/ui/home/widgets/title_section.dart';
import 'controllers/home_controller.dart';
import '../../../garage/ui/garage/widgets/car_card_widget.dart';
import '../../../garage/ui/garage/widgets/car_container_widget.dart';
import 'widgets/notification_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController(Get.find()));
    return Scaffold(
      appBar: const AppBarWithAvatarAndSalutation(
        greetingMessage: 'Good Morning',
        userName: 'James',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
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

              if (Get.isRegistered<FeatureWidgetInterface>(
                  tag: 'ListVehicleWidget'))
                Get.find<FeatureWidgetInterface>(tag: 'ListVehicleWidget')
                    .buildView(),
              const SizedBox(height: 5),
              const TitleSection(nameSection: 'Upcoming Activities'),
              /*  SizedBox(height: 500, child: HorizontalListView()), */
              const CarCardWidget(
                date: '02/02/23',
                time: '00:02',
                localisation: 'Yaoundé',
                nameCar: 'Turbo Moteur',
                pathImageCar:
                    'https://s3-alpha-sig.figma.com/img/1a76/2a6f/5e8173900d54188840dcc505afaab0b3?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Rub6vLCB3USasOCi8DKeP~0uJcH131QNXWNteLu00apeGOD2N4Nzb1aNIqeMh~0DHvoJA8N2j5ekuCKwFGpW31N9IDWtAOur5zTByAEX66zsr2eALqm5ra1i1l7cIoPG8JbwegYa3a1eN72m59UJGaCzo7b2TM~rVVvN2Pign1rgPAEHppzwnmeGQaaDkf2vf-xR5WSqmbuMPP3pLOG8j9YxoHMgIdzKExKghycrIoEnL3-FqgCXW4lbnIWNhw06iD7toWwFgKjQuYexAcFh-S~CfuTz8cUq7bhh7cyEx8zRuRhvaFgLixqymuCwqxMbPGFop3t1PUWaw5OWVAfajw__',
                status: 'Completed',
              ),
              /*** */
              const TitleSection(nameSection: 'Services'),
              Row(
                children: [
                  Expanded(
                    child: CustomCardService(
                      color: Color(0xFFF4EEFF),
                      text: 'VIN\nLookup',
                      imagePath: AppImages.vin,
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const HomeLocatorScreen()),
                        // );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomCardService(
                      color: Color(0xFFFFEDE6),
                      text: 'Service\nLocator',
                      imagePath: AppImages.service,
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const HomeLocatorScreen()),
                        // );
                      },
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
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           const VehicleReportScreen()),
                        // );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomCardService(
                      color: Color(0xFFFFDAD4),
                      text: 'Emergency\nAssistance',
                      imagePath: AppImages.emergency,
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           const FirstHomeAssistanceScreen()),
                        // );
                      },
                    ),
                  ),
                ],
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
      ),
    );
  }
}
