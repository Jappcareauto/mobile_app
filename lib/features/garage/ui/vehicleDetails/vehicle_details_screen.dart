import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/ui/interfaces/feature_widget_interface.dart';
import '../../../../core/ui/widgets/custom_app_bar.dart';
import '../../../../core/ui/widgets/image_component.dart';
import '../../../../core/utils/app_images.dart';
import '../garage/widgets/recent_activities_widget.dart';
import 'controllers/vehicle_details_controller.dart';
import 'package:get/get.dart';
import 'widgets/detail_item.dart';
import 'widgets/diagram_widget.dart';

class VehicleDetailsScreen extends GetView<VehicleDetailsController> {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Garage",
        canBack: true,
        actions: [
          if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
            Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text("Porsche 911 GT3RS",
                    style: Get.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Get.theme.primaryColor)),
                Text("DW056663", style: Get.textTheme.bodyMedium),
                const ImageComponent(assetPath: AppImages.carWhite),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    DetailItem(title: "Make", value: "Porsche"),
                    SizedBox(width: 20),
                    DetailItem(title: "Model", value: "911"),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    DetailItem(title: "Trim", value: "Turbo S"),
                    SizedBox(width: 20),
                    DetailItem(title: "Year", value: "2024"),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    DetailItem(title: "Transmission", value: "Automatic"),
                    SizedBox(width: 20),
                    DetailItem(title: "Drive", value: "Electric"),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    DetailItem(title: "Power", value: "982 bhp"),
                    SizedBox(width: 20),
                    DetailItem(title: "Body Type", value: "Sedan"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: EarningsGraph(
              totalEarnings: 284000,
              selectedPointLabel: '28,000Frs',
              selectedPointValue: 28000,
              dataPoints: [
                FlSpot(1, 10),
                FlSpot(5, 3),
                FlSpot(10, 18),
                FlSpot(15, 22),
                FlSpot(20, 10),
                FlSpot(25, 27),
                FlSpot(30, 23),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const RecentActivitiesWidget(haveTabBar: false),
        ]),
      ),
    );
  }
}
