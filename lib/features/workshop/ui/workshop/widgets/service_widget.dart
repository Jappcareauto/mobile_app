import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_services.dart';

class ServiceWidget extends StatelessWidget {
  final List<String> tabs; // List of tabs
  final RxInt selectedFilter; // Selected tab index
  late RxString selectedTabs; // Selected tab
  final List<ServiceEntity>? data; // List of data
  final BorderRadius borderRadius;
  final bool haveBorder;
  final Function(ServiceEntity selectCar)? onSelected;
  final bool? canSelect;
  ServiceWidget(
      {super.key,
      required this.tabs,
      this.data,
      this.onSelected,
      required this.selectedFilter,
      required this.selectedTabs,
      this.canSelect,
      required this.borderRadius,
      required this.haveBorder});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (data!.isNotEmpty && onSelected != null) {
        onSelected!(data![0]);
      }
    });
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 10,
        children: List.generate(tabs.length, (index) {
          return Obx(() {
            final category = tabs[index];
            return GestureDetector(
              onTap: () {
                if (canSelect == null || !canSelect!) return;
                selectedFilter.value = index;
                selectedTabs.value = category;
                onSelected!(data![index]);
              },
              child: Container(
                width: 175,
                margin: const EdgeInsets.fromLTRB(0, 16, 8, 16),
                padding: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: selectedFilter.value == index
                      ? haveBorder == true
                          ? AppColors.secondary
                          : AppColors.primary
                      : AppColors.secondary,
                  border: Border.all(
                      color: selectedFilter.value == index
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
                        tabs[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedFilter.value == index
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ImageComponent(
                          assetPath: AppImages.maintenance,
                          width: 120,
                          height: 120,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        }),
      ),
    );
  }
}
