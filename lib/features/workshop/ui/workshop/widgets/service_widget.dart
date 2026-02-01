// import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_services.entity.dart';

class ServiceWidget extends StatelessWidget {
  final List<ServiceEntity> tabs; // List of tabs
  final int? selectedFilter; // Selected tab index (-1 means "All" is selected)
  final BorderRadius? borderRadius;
  final bool? haveBorder;
  final Function(int index)? onSelected;
  final Function? onInit;
  final bool showAllOption;

  const ServiceWidget({
    super.key,
    required this.tabs,
    this.onSelected,
    this.onInit,
    this.selectedFilter,
    this.borderRadius,
    this.haveBorder,
    this.showAllOption = true,
  });

  // Get icon based on service title
  String _getServiceIcon(String title) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('maintenance') || lowerTitle.contains('general')) {
      return AppImages.maintenance;
    } else if (lowerTitle.contains('inspection') ||
        lowerTitle.contains('vehicle')) {
      return AppImages.vehicule;
    } else if (lowerTitle.contains('cleaning') ||
        lowerTitle.contains('clean')) {
      return AppImages.carClean;
    } else if (lowerTitle.contains('body') || lowerTitle.contains('repair')) {
      return AppImages.carBody;
    } else if (lowerTitle.contains('emergency')) {
      return AppImages.emergency;
    } else if (lowerTitle.contains('vin')) {
      return AppImages.vin;
    }
    return AppImages.service;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 12,
        children: [
          // "All" card to clear filters
          if (showAllOption)
            _buildServiceCard(
              title: 'All',
              iconPath: AppImages.service,
              isSelected: selectedFilter == -1,
              onTap: () => onSelected?.call(-1),
            ),
          // Service cards
          ...List.generate(
            tabs.length,
            (index) {
              final item = tabs[index];
              final serviceTitle = item.title
                  .split("_")
                  .map((e) =>
                      '${e[0].toUpperCase()}${e.substring(1).toLowerCase()}')
                  .join("\n");

              return _buildServiceCard(
                title: serviceTitle,
                iconPath: _getServiceIcon(item.title),
                isSelected: selectedFilter == index,
                onTap: () => onSelected?.call(index),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String iconPath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 120,
      height: 110,
      decoration: BoxDecoration(
        color: AppColors.secondary2,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.secondary2,
          width: 2,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          splashColor: AppColors.primary.withValues(alpha: 0.2),
          highlightColor: AppColors.primary.withValues(alpha: 0.1),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ImageComponent(
                    assetPath: iconPath,
                    width: 45,
                    height: 45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
