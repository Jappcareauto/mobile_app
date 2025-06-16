import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/features/chat/ui/chat/controllers/chat_details_controller.dart';

class ChatInputWidget extends StatelessWidget {
  final VoidCallback onAttach;

  final VoidCallback onMic;
  final ChatDetailsController chatController;
  const ChatInputWidget({
    super.key,
    required this.chatController,
    required this.onAttach,
    required this.onMic,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (chatController.selectedImages.isNotEmpty)
              Container(
                decoration: const BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50))),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(
                      () => Row(
                        children: chatController.selectedImages
                            .asMap()
                            .entries
                            .map((entry) {
                          final index = entry.key;
                          final imagePath = entry.value;
                          return SizedBox(
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
                                  child: IconButton(
                                      onPressed: () {
                                        chatController.removeImage(index);
                                      },
                                      icon: const Icon(
                                          FluentIcons.dismiss_12_filled)))
                            ],
                          ));
                        }).toList(),
                      ),
                    )),
              ),
            Row(
              children: [
                // Zone de texte avec bordure arrondie
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: const Color(
                          0xFFFFF2F0), // Couleur d'arrière-plan rosé
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        // Zone de texte
                        Expanded(
                          child: TextField(
                            controller: chatController.messageController,
                            decoration: const InputDecoration(
                              hintText: "Write a message",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        // Icônes d'actions
                        // IconButton(
                        //   icon: const Icon(Icons.attach_file),
                        //   onPressed: onAttach,
                        // ),
                        IconButton(
                          icon: const Icon(Icons.camera_alt),
                          onPressed: chatController.pickImage,
                        ),

                        // if (chatController.messageController.text.isEmpty)
                        //   IconButton(
                        //     icon: const Icon(Icons.mic),
                        //     onPressed: onMic,
                        //   ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 2.0),
                // Bouton d'envoi
                GestureDetector(
                  onTap: () {
                    chatController
                        .sendMessage(chatController.messageController.text);
                    print(chatController.messageController.text);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          Get.theme.primaryColor, // Couleur du bouton d'envoi
                    ),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
