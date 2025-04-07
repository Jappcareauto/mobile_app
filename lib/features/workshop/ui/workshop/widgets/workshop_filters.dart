import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/services_list_widget.dart';
// import 'package:jappcare/core/ui/widgets/image_component.dart';
// import 'package:jappcare/features/workshop/ui/chat/controllers/chat_controller.dart';
// import 'package:jappcare/features/workshop/ui/workshop/controllers/workshop_controller.dart';

class WorkshopFilters extends StatelessWidget {
  // final WorkshopController workshopController =
  //     Get.put(WorkshopController(Get.find()));
  // final VoidCallback onConfirm;
  const WorkshopFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 5,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Get.theme.primaryColor),
              child: Text(
                'Around Me',
                style: Get.textTheme.bodyMedium
                    ?.copyWith(color: Get.theme.scaffoldBackgroundColor),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Get.theme.primaryColor),
              child: Text(
                'Available Now',
                style: Get.textTheme.bodyMedium
                    ?.copyWith(color: Get.theme.scaffoldBackgroundColor),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       color: Get.theme.primaryColor),
            //   child: Text(
            //     'Available Now',
            //     style: Get.textTheme.bodyMedium
            //         ?.copyWith(color: Get.theme.scaffoldBackgroundColor),
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: 20),
        ServicesListWidget(),
      ],
    );
  }
}
