import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/ui/interfaces/feature_widget_interface.dart';
import '../../../../../core/utils/app_images.dart';
import 'car_card_add_vehicle.dart';
import 'car_container_widget.dart';
import 'shimmers/garage_name_shimmer.dart';
import 'shimmers/list_vehicle_shimmer.dart';

class ListVehicleWidget extends StatelessWidget
    implements FeatureWidgetInterface {
  final bool haveTitle;
  final String title;
  final Function(int index)? onSelected;
  final int? selectedIndex;
  const ListVehicleWidget(
      {super.key,
      this.haveTitle = true,
      this.title = "My Garage",
      this.onSelected,
      this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<GarageController>(
      init: GarageController(Get.find()),
      initState: (_) {},
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (haveTitle)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _.loading.value
                    ? const MyGarageNameShimmer()
                    : Text(_.myGarage?.name ?? title,
                        style: Get.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
              ),
            if (haveTitle) const SizedBox(height: 5),
            _.loading.value
                ? const ListVehicleShimmer()
                : SizedBox(
                    height: 190,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        const SizedBox(width: 20),
                        if (_.vehicleList.isNotEmpty)
                          ..._.vehicleList
                              .asMap()
                              .entries
                              .map((e) => CarContainer(
                                    carName: e.value.name,
                                    carDetails: e.value.description ?? '',
                                    imagePath: AppImages.car,
                                    principalColor: Get.theme.primaryColor,
                                    isSelected: selectedIndex != null
                                        ? selectedIndex == e.key
                                        : null,
                                    onPressed: onSelected != null
                                        ? () => onSelected!(e.key)
                                        : _.goToVehicleDetails,
                                  )),
                        CarCardAddVehicle(
                          carName: 'Porsche 911 GT3RS',
                          carDetails: '2024, RWD',
                          imagePath: AppImages.carWhite,
                          isSelected:
                              selectedIndex != null ? selectedIndex == 2 : null,
                          onPressed: _.goToAddVehicle,
                        ),
                      ],
                    ),
                  ),
          ],
        );
      },
    );
  }

  @override
  Widget buildView([args]) {
    return this;
  }
}
