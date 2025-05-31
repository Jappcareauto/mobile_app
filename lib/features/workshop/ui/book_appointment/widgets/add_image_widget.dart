import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';

class AddImageWidget extends GetView<BookAppointmentController> {
  const AddImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Images',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(right: 20),
              child: Obx(
                () => Row(
                  spacing: 12,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Affiche les autres containers uniquement si la liste n'est pas vide
                    ...controller.selectedImages.map((imagePath) {
                      return SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              Image.file(
                                imagePath, // Ajuster la taille de l'image
                                fit: BoxFit.cover,
                                width: Get.width,
                                height: Get.height,
                              ),
                              Positioned(
                                  top: -0,
                                  left: -0,
                                  child: GestureDetector(
                                    onTap: () => controller
                                        .removeImageFromGallery(imagePath),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Icon(
                                        FluentIcons.delete_24_regular,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    }),
                    // Conteneur par défaut (toujours présent)

                    GestureDetector(
                      onTap: () {
                        print('Pick photo');
                        controller.selectImagesFromGallery();
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Get.theme.primaryColor
                              .withValues(alpha: .2), // Couleur par défaut
                        ),
                        child: Center(
                          child: Icon(
                            FluentIcons.add_24_filled,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
