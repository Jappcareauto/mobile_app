import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:jappcare/core/utils/app_images.dart';

import '../../../../../core/ui/interfaces/feature_widget_interface.dart';
import '../../../../../core/ui/widgets/custom_tab_bar.dart';
import 'car_card_widget.dart';

class RecentActivitiesWidget extends StatelessWidget
    implements FeatureWidgetInterface {
  final String title;
  final bool haveTitle;
  final bool haveTabBar;
  final bool isHorizontal;
  final String? status;
  const RecentActivitiesWidget(
      {super.key,
      this.title = "Recent Activities",
      this.haveTitle = true,
      this.haveTabBar = true,
      this.isHorizontal = false,
      this.status});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GarageController>(
      init: GarageController(Get.find()),
      autoRemove: false,
      initState: (_) {},
      builder: (_) {
        var ws = _.vehicleList
            .map(
              (e) => CarCardWidget(
                date: '02/02/23',
                time: '00:02',
                localisation: 'Yaoundé',
                nameCar: 'Turbo Moteur',
                pathImageCar: e.imageUrl,
                status: 'Completed',
                onPressed: () => _.goToVehicleDetails(e),
              ),
            )
            .toList();
        if (status != null) {
          ws = ws.where((w) => w.status == status).toList();
        }
        return _.vehicleList.isEmpty
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (haveTitle)
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        title,
                        style: Get.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  if (haveTitle) const SizedBox(height: 15),
                  if (haveTabBar)
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: CustomTabBar(
                        labels: const ["All", "Ongoing", "Completed"],
                        onTabSelected: (index) {},
                      ),
                    ),
                  if (haveTabBar) const SizedBox(height: 20),
                  isHorizontal
                      ? SizedBox(
                          height: 220,
                          child: ListView(
                              scrollDirection: Axis.horizontal, children: ws))
                      : Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Column(children: ws),
                        )
                ],
              );
      },
    );
  }

  @override
  Widget buildView([args]) {
    if (args != null && args is bool) {
      return RecentActivitiesWidget(haveTabBar: args);
    } else if (args != null && args is String) {
      return RecentActivitiesWidget(
        title: args,
      );
    } else if (args != null && args is Map) {
      return RecentActivitiesWidget(
        haveTabBar: args['haveTabBar'] ?? true,
        haveTitle: args['haveTitle'] ?? true,
        title: args['title'] ?? 'Recent Activities',
        isHorizontal: args['isHorizontal'] ?? false,
        status: args['status'],
      );
    } else {
      return this;
    }
  }
}
