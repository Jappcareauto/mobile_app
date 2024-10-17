import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/ui/interfaces/feature_widget_interface.dart';
import '../../../../../core/utils/app_images.dart';
import 'car_card_add_vehicle.dart';
import 'car_container_widget.dart';

class ListVehicleWidget extends StatelessWidget
    implements FeatureWidgetInterface {
  final bool haveTitle;
  const ListVehicleWidget({super.key, this.haveTitle = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (haveTitle)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("My Garage",
                style: Get.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
        if (haveTitle)
          const SizedBox(
            height: 5,
          ),
        SizedBox(
          height: 190,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SizedBox(width: 20),
              CarContainer(
                  carName: 'Avensis Turbo',
                  carDetails: 'DW056663',
                  imagePath: AppImages.car,
                  principalColor: Get.theme.primaryColor),
              CarContainer(
                  carName: 'Avensis Turbo',
                  carDetails: 'DW056663',
                  imagePath: AppImages.car,
                  principalColor: Get.theme.primaryColor),
              const CarCardAddVehicle(
                carName: 'Porsche 911 GT3RS',
                carDetails: '2024, RWD',
                imagePath: AppImages.carWhite,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget buildView([args]) {
    return this;
  }
}
