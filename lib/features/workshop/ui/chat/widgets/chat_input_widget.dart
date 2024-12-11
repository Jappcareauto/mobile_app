import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/chat/controllers/chat_controller.dart';

class ChatInputWidget extends GetView<ChatController> {

  final VoidCallback onAttach;

  final VoidCallback onMic;
  final ChatController chatController;
  const ChatInputWidget({
    Key? key,
    required this.chatController,
    required this.onAttach,
    required this.onMic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
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
                      controller: chatController.messageController,
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
                    onPressed: chatController.pickImage,
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
              chatController.sendMessage ;
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
    );
  }
}
