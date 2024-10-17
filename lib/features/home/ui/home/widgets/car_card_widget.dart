import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/features/home/ui/home/widgets/chip_widget.dart';

class CarCardWidget extends StatelessWidget {
  const CarCardWidget({
    super.key,
    required this.date,
    required this.time,
    required this.localisation,
    required this.nameCar,
    required this.status,
    required this.pathImageCar,
    this.widthCard,
    this.heightCard,
  });

  final String date;
  final String time;
  final String localisation;
  final String nameCar;
  final String status;
  final String pathImageCar;
  final double? widthCard;
  final double? heightCard;

  @override
  Widget build(BuildContext context) {
    // Déterminer la couleur en fonction du statut

    return Container(
      width: widthCard,
      height: heightCard,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color.fromARGB(255, 207, 207, 207)),
      ),
      child: ListTile(
        shape: const CircleBorder(),
        title: Container(
          margin: const EdgeInsets.only(bottom: 25),
          child: Row(
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
        ),
        subtitle: Row(
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
                    Text(date),
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
                    Text(time),
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
                    Text(localisation),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                ImageComponent(
                  imageUrl: pathImageCar,
                  width: 200,
                ),
                Text(
                  nameCar,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
