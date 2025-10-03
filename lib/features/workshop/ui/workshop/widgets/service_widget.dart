// import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
// import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_services.entity.dart';

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
        children: List.generate(
          tabs.length,
          (index) {
            final item = tabs[index];
            final serviceTItle = item.title
                .split("_")
                .map((e) =>
                    '${e[0].toUpperCase()}${e.substring(1).toLowerCase()}')
                .join(" ");

            return Container(
              // width: 175,
              // height: 200,
              margin: const EdgeInsets.only(right: 8),
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
              child: Material(
                color: Colors.transparent,
                borderRadius: borderRadius,
                child: InkWell(
                  onTap: () {
                    onSelected?.call(index);
                  },
                  borderRadius: borderRadius,
                  splashColor: AppColors.primary.withValues(alpha: 0.2),
                  highlightColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            serviceTItle,
                            style: TextStyle(
                                fontSize: 14,
                                color: selectedFilter == index
                                    ? haveBorder == true
                                        ? AppColors.black
                                        : AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.1),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     ImageComponent(
                        //       assetPath: item.definition == "VEHICLE_MAINTENANCE"
                        //           ? AppImages.maintenance
                        //           : item.definition == "ENGINE_DIAGNOSTICS"
                        //               ? AppImages.vehicule
                        //               : item.definition == "VIN_DETECTION"
                        //                   ? AppImages.vin
                        //                   : AppImages.maintenance,
                        //       width: 120,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
