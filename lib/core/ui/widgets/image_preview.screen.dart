import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'dart:io';

import 'package:jappcare/features/chat/ui/chat/controllers/chat_details_controller.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String imagePath;
  final TextEditingController captionController = TextEditingController();

  ImagePreviewScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        // title: const Text(
        //   'Send Image',
        //   style: TextStyle(color: Colors.white),
        // ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Image Display
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ImageComponent(
                    file: File(imagePath),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // Caption Input Section
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                spacing: 5,
                children: [
                  // Caption input field
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        // color: const Color(
                        //     0xFFFFF2F0), // Couleur d'arrière-plan rosé
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextField(
                        controller: captionController,
                        decoration: InputDecoration(
                          hintText: 'Add a caption...',
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        maxLines: 3,
                        minLines: 1,
                      ),
                    ),
                  ),
                  // Bouton d'envoi
                  GestureDetector(
                    onTap: () => _sendImage(),
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            Get.theme.primaryColor, // Couleur du bouton d'envoi
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendImage() {
    final caption = captionController.text.trim().toString();

    print(caption);
    print(imagePath);

    // // Show loading dialog
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    // // Get the chat controller and send the image
    final chatController = Get.find<ChatDetailsController>();
    chatController.sendImageMessage(imagePath, caption).then((_) {
      Get.back(); // Close loading dialog
      Get.back(result: imagePath); // Go back to chat screen
      // Get.snackbar(
      //   'Success',
      //   'Image sent successfully!',
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      // );
    }).catchError((error) {
      Get.back(); // Close loading dialog
      // Get.snackbar(
      //   'Error',
      //   'Failed to send image: $error',
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
    });
  }
}
