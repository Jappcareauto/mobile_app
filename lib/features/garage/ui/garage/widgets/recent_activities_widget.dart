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
      init: GarageController(Get.find(),Get.find()),
      autoRemove: false,
      initState: (_) {},
      builder: (_) {
        var ws = _.vehicleList
            .map(
              (e) => CarCardWidget(
                latitude: _.myGarage!.location!.latitude ,
                longitude: _.myGarage!.location!.longitude,
                date: "${DateTime.parse(_.myGarage!.location!.createdAt).year}/${DateTime.parse(_.myGarage!.location!.createdAt).month.toString().padLeft(2, '0')}/${DateTime.parse(_.myGarage!.location!.createdAt).day.toString()..toString().padLeft(2, '0')}",
                time: "${DateTime.parse(_.myGarage!.location!.createdAt).hour.toString().padLeft(2, '0')}:${DateTime.parse(_.myGarage!.location!.createdAt).minute.toString().padLeft(2, '0')}:${DateTime.parse(_.myGarage!.location!.createdAt).second.toString().padLeft(2, '0')}",
                localisation: _.myGarage!.location!.latitude.toString(),
                nameCar: e.name,
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
                          height: 250,
                          width: MediaQuery.of(context).size.width,
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
