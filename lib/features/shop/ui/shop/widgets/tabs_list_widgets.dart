import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/domain/entities/get_allservices.dart';

class TabsListWidgets extends StatelessWidget {
  final List<String> tabs;

  final RxInt selectedFilter;
  late RxString selectedTabs;
  final List<Data>? data;
  final BorderRadius borderRadius;
  final bool haveBorder;
  final Function(Data selectCar)? onSelected;
  TabsListWidgets(
      {super.key,
      required this.tabs,
      this.data,
      this.onSelected,
      required this.selectedFilter,
      required this.selectedTabs,
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
        children: List.generate(tabs.length, (index) {
          return Obx(() {
            final category = tabs[index];
            return GestureDetector(
              onTap: () {
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
                          ? const Color(0xFFFB7C37)
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
