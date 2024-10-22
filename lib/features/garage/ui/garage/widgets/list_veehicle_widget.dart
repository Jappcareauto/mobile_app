import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import '../../../../../core/ui/interfaces/feature_widget_interface.dart';
import '../../../../../core/utils/app_images.dart';
import 'car_card_add_vehicle.dart';
import 'car_container_widget.dart';

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
    return GetBuilder<GarageController>(
      init: GarageController(Get.find()),
      initState: (_) {},
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (haveTitle)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(title,
                    style: Get.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
            if (haveTitle) const SizedBox(height: 5),
            SizedBox(
              height: 190,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  const SizedBox(width: 20),
                  CarContainer(
                    carName: 'Avensis Turbo',
                    carDetails: 'DW056663',
                    imagePath: AppImages.car,
                    principalColor: Get.theme.primaryColor,
                    isSelected:
                        selectedIndex != null ? selectedIndex == 0 : null,
                    onPressed: onSelected != null
                        ? () => onSelected!(0)
                        : _.goToVehicleDetails,
                  ),
                  CarContainer(
                    carName: 'Avensis Turbo',
                    carDetails: 'DW056663',
                    imagePath: AppImages.car,
                    principalColor: Get.theme.primaryColor,
                    isSelected:
                        selectedIndex != null ? selectedIndex == 1 : null,
                    onPressed: onSelected != null
                        ? () => onSelected!(1)
                        : _.goToVehicleDetails,
                  ),
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
