import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_services.dart';

class ServiceWidget extends StatelessWidget {
  final List<ServiceEntity> tabs; // List of tabs
  final int? selectedFilter; // Selected tab index
  final BorderRadius? borderRadius;
  final bool? haveBorder;
  final Function(int index)? onSelected;
  final Function? onInit;

  const ServiceWidget(
      {super.key,
      required this.tabs,
      this.onSelected,
      this.onInit,
      this.selectedFilter,
      this.borderRadius,
      this.haveBorder});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 4,
        children: List.generate(tabs.length, (index) {
          final item = tabs[index];
          return GestureDetector(
            onTap: () {
              onSelected?.call(index);
            },
            child: Container(
              width: 175,
              margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: selectedFilter == index
                    ? haveBorder == true
                        ? AppColors.secondary
                        : AppColors.primary
                    : AppColors.secondary,
                border: Border.all(
                    color: selectedFilter == index
                        ? AppColors.primary
                        : const Color(0xFFFFEDE6),
                    width: 1.5),
                borderRadius: borderRadius,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 16,
                        color: selectedFilter == index
                            ? haveBorder == true
                                ? AppColors.black
                                : AppColors.white
                            : AppColors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ImageComponent(
                        assetPath: item.definition == "VEHICLE_MAINTENANCE"
                            ? AppImages.maintenance
                            : item.definition == "ENGINE_DIAGNOSTICS"
                                ? AppImages.vehicule
                                : item.definition == "VIN_DETECTION"
                                    ? AppImages.vin
                                    : AppImages.maintenance,
                        width: 120,
                        height: 120,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
