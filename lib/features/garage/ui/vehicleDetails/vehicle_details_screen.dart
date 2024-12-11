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
    final _vhcle = controller.vehicleModel;
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
                Text(_vhcle.name,
                    style: Get.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Get.theme.primaryColor)),
                Text(_vhcle.vin, style: Get.textTheme.bodyMedium),
                ImageComponent(
                  assetPath:
                      _vhcle.imageUrl != null ? null : AppImages.carWhite,
                  imageUrl: _vhcle.imageUrl,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    DetailItem(
                        title: "Make", value: _vhcle.detail?.make ?? 'Unknow'),
                    const SizedBox(width: 20),
                    DetailItem(
                        title: "Model",
                        value: _vhcle.detail?.model ?? 'Unknow'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    DetailItem(
                        title: "Trim", value: _vhcle.detail?.trim ?? 'Unknow'),
                    const SizedBox(width: 20),
                    DetailItem(
                        title: "Year", value: _vhcle.detail?.year ?? 'Unknow'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    DetailItem(
                        title: "Transmission",
                        value: _vhcle.detail?.transmission ?? 'Unknow'),
                    const SizedBox(width: 20),
                    DetailItem(
                        title: "Drive",
                        value: _vhcle.detail?.driveTrain ?? 'Unknow'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    DetailItem(
                        title: "Power",
                        value: _vhcle.detail?.power ?? 'Unknow'),
                    const SizedBox(width: 20),
                    DetailItem(
                        title: "Body Type",
                        value: _vhcle.detail?.bodyType ?? 'Unknow'),
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
