import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/controllers/appointment_details_controller.dart';

class ExpandableContainer extends StatelessWidget {
  final String title;
  final Widget subtitle;
  final String description;
  final RxBool visibility;
  final VoidCallback onExpand;
  final List<String> imageUrls;
  final AppointmentDetailsController controller;

  const ExpandableContainer({
    super.key,
    required this.onExpand,
    required this.title,
    required this.visibility,
    required this.subtitle,
    required this.description,
    required this.imageUrls,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre avec bouton d'extension/réduction
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          trailing: Obx(
            () => IconButton(
              icon: Icon(
                visibility.value
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_right,
              ),
              onPressed: onExpand,
            ),
          ),
        ),
        // Contenu extensible
        Obx(
          () => Visibility(
            visible: visibility.value,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey.withValues(alpha: .2), width: 1),
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subtitle,
                  // Description
                  Column(
                    children: [
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14.0,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      // if (imageUrls.isNotEmpty)
                      //   const Text(
                      //     'Images',
                      //     style: TextStyle(
                      //         fontSize: 14.0, height: 1.5, color: Colors.grey),
                      //   ),

                      // Images horizontales
                      if (imageUrls.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: imageUrls.map((imageUrl) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: ImageComponent(
                                    assetPath: imageUrl,
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
