
import 'package:flutter/material.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import '../controllers/chat_controller.dart';
import 'package:get/get.dart';
import 'dart:io';

class ChatInputField extends StatelessWidget {
  final ChatController chatController;

  const ChatInputField({
    Key? key,
    required this.chatController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Obx(
          () => Column(
        children: [
          if (chatController.selectedImages.isNotEmpty)
            Container(
              height: 90.0,
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(16.0))),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: chatController.selectedImages.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          File(chatController.selectedImages[index].path),
                          width: 70.0,
                          height: 70.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => chatController.removeImage(index),
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 12,
                            child: Icon(Icons.close,
                                size: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          Container(
            margin: const EdgeInsets.symmetric(
                vertical:8, horizontal: 16),
            padding: const EdgeInsets.symmetric(
                horizontal:8, vertical: 4),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.black : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(32)),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.orange,
                  blurRadius: 2.0,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    maxLines: 4,
                    minLines: 1,
                    controller: chatController.messageController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: "Write your message",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt, color: AppColors.orange),
                  onPressed: chatController.pickImage,
                ),
                IconButton(
                  icon: Icon(Icons.send, color: AppColors.orange),
                  onPressed: chatController.sendMessage,
                ),
              ],
            ),
          ),
          const SizedBox(height:8),
        ],
      ),
    );
  }
}