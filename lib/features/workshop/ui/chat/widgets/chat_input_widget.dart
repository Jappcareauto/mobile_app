
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/features/workshop/ui/chat/controllers/chat_controller.dart';

class ChatInputWidget extends GetView<ChatController> {

  final VoidCallback onAttach;

  final VoidCallback onMic;

  const ChatInputWidget({
    super.key,

    required this.onAttach,
    required this.onMic,
  });

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:Column(
        children: [
          if (controller.selectedImages.isNotEmpty)
            Container(
              decoration: const BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50)
                )
              ),
              child:  SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(() =>
                      Row(
                        children: controller.selectedImages.asMap().entries.map((entry) {
                          final index = entry.key;
                          final imagePath = entry.value;
                          return Container(

                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      imagePath, // Ajuster la taille de l'image
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                      child:IconButton(onPressed: (){
                                        controller.removeImage(index);
                                      },
                                          icon: const Icon(FluentIcons.dismiss_12_filled))
                                  )
                                ],
                              )

                          );
                        }).toList(),
                      ),
                  )
              ),
            ),


          Row(
            children: [
              // Zone de texte avec bordure arrondie
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF2F0), // Couleur d'arrière-plan rosé
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    children: [
                      // Zone de texte
                      Expanded(
                        child: TextField(
                          controller: controller.messageController,
                          decoration: const InputDecoration(
                            hintText: "Write a message",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      // Icônes d'actions
                      IconButton(
                        icon: const Icon(Icons.attach_file),
                        onPressed: onAttach,
                      ),
                      IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: controller.pickImage,
                      ),
                      IconButton(
                        icon: const Icon(Icons.mic),
                        onPressed: onMic,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 2.0),
              // Bouton d'envoi
              GestureDetector(
                onTap: () {
                  controller.sendMessage() ;
                  print(controller.messageController.text);
                },

                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange, // Couleur du bouton d'envoi
                  ),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      )

    );
  }
}
