import 'package:flutter/material.dart';
import 'package:jappcare/features/home/ui/home/widgets/service_widget.dart';
import '../../../../core/ui/interfaces/feature_widget_interface.dart';
import '../../../../core/ui/widgets/custom_app_bar.dart';
import '../../../../core/ui/widgets/image_component.dart';
import '../../../../core/utils/app_images.dart';
import '../garage/widgets/recent_activities_widget.dart';
import 'controllers/vehicle_details_controller.dart';
import 'package:get/get.dart';
import 'widgets/detail_item.dart';

class VehicleDetailsScreen extends GetView<VehicleDetailsController> {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vhcle = controller.vehicleModel;
    return Scaffold(
      appBar: CustomAppBar(
        appBarcolor: Get.theme.scaffoldBackgroundColor,
        title: "My Garage",
        canBack: true,
        actions: [
          if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
            Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      vhcle.detail != null
                          ? "${vhcle.detail!.make} ${vhcle.detail!.model}"
                          : '',
                      style: Get.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Get.theme.primaryColor)),
                  Text(vhcle.detail?.year ?? "",
                      style: Get.textTheme.bodyMedium),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: Get.width,
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: vhcle.media
                              ?.map((e) => Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: ImageComponent(
                                      assetPath: e?.sourceUrl != null
                                          ? null
                                          : AppImages.carWhite,
                                      imageUrl: e?.sourceUrl,
                                      width: Get.width * .85,
                                      borderRadius: 10,
                                    ),
                                  ))
                              .toList() ??
                          [
                            vhcle.imageUrl != null
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: ImageComponent(
                                      assetPath: vhcle.imageUrl != null
                                          ? null
                                          : AppImages.carWhite,
                                      imageUrl: vhcle.imageUrl,
                                      width: Get.width * .85,
                                      borderRadius: 10,
                                    ),
                                  )
                                : SizedBox(
                                    width: Get.width * .85,
                                    height: 200,
                                    child:
                                        const Center(child: Text("No Media")))
                          ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      DetailItem(
                          title: "Make", value: vhcle.detail?.make ?? 'Unknow'),
                      const SizedBox(width: 20),
                      DetailItem(
                          title: "Model",
                          value: vhcle.detail?.model ?? 'Unknow'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      DetailItem(
                          title: "Trim", value: vhcle.detail?.trim ?? 'Unknow'),
                      const SizedBox(width: 20),
                      DetailItem(
                          title: "Year", value: vhcle.detail?.year ?? 'Unknow'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      DetailItem(
                          title: "Transmission",
                          value: vhcle.detail?.transmission ?? 'Unknow'),
                      const SizedBox(width: 20),
                      DetailItem(
                          title: "Drive",
                          value: vhcle.detail?.driveTrain ?? 'Unknow'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      DetailItem(
                          title: "Power",
                          value: vhcle.detail?.power ?? 'Unknow'),
                      const SizedBox(width: 20),
                      DetailItem(
                          title: "Body Type",
                          value: vhcle.detail?.bodyType ?? 'Unknow'),
                    ],
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 20),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: EarningsGraph(
            //     totalEarnings: 284000,
            //     selectedPointLabel: '28,000Frs',
            //     selectedPointValue: 28000,
            //     dataPoints: [
            //       FlSpot(1, 10),
            //       FlSpot(5, 3),
            //       FlSpot(10, 18),
            //       FlSpot(15, 22),
            //       FlSpot(20, 10),
            //       FlSpot(25, 27),
            //       FlSpot(30, 23),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find a service for your car',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: CustomCardService(
                        color: const Color(0xFFC4FFCD),
                        text: 'Vehicles\nReports',
                        imagePath: AppImages.vehicule,
                        onTap: () {}
                        // controller.goToVehicleReport

                        ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomCardService(
                      color: const Color(0xFFFFDAD4),
                      text: 'Emergency\nAssistance',
                      imagePath: AppImages.emergency,
                      onTap: () {
                        // controller.goToEmergency();
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            RecentActivitiesWidget(haveTabBar: false),
          ]),
        ),
      ),
    );
  }
}
