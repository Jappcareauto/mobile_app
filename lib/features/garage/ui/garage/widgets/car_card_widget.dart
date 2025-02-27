import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/chip_widget.dart';

import '../../../../../core/utils/app_images.dart';

class CarCardWidget extends GetView<GarageController> {
  const CarCardWidget({
    super.key,
    required this.date,
    required this.time,
    required this.localisation,
    required this.nameCar,
    required this.status,
    required this.latitude,
    required this.longitude,
    this.pathImageCar,
    this.widthCard,
    this.heightCard,
    this.onPressed,
  });

  final String date;
  final String time;
  final String localisation;
  final String nameCar;
  final String status;
  final String? pathImageCar;
  final double? widthCard;
  final double? heightCard;
  final double longitude;
  final double latitude;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    // Déterminer la couleur en fonction du statut
    controller.getPlaceName(longitude, latitude);
    return Obx(() =>
        Container(
          width: widthCard,
          height: heightCard,
          margin: const EdgeInsets.only(bottom: 12, left: 20),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.lightBorder),
              color: Get.theme.cardColor),
          child: InkWell(
            onTap: onPressed,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BodyShop Appointment',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.orange),
                      ),
                      Text(
                        'Japcare AutoShop',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  ChipWidget(
                    status: status,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            FluentIcons.calendar_ltr_12_regular,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 10),
                          Text(date, style: Get.textTheme.bodySmall),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            FluentIcons.clock_12_regular,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 10),
                          Text(time, style: Get.textTheme.bodySmall),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            FluentIcons.location_12_regular,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 10),

                          Text(controller.placeName.value ?? localisation, style: Get.textTheme
                              .bodySmall),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageComponent(
                        imageUrl: pathImageCar,
                        assetPath: AppImages.car,
                        width: Get.width * 0.4,
                      ),
                      const SizedBox(height: 8),
                      // Ajout d'un espacement entre l'image et le texte
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          nameCar,
                          textAlign: TextAlign.center,
                          // Centre le texte
                          overflow: TextOverflow.ellipsis,
                          // Tronque le texte si trop long
                          maxLines: 1,
                          // Limite le texte à une seule ligne
                          style: const TextStyle(
                            fontSize: 12, // Ajuste la taille de la police
                            fontWeight: FontWeight.bold, // Style en gras
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ]),
          ),
        ));
  }
}
