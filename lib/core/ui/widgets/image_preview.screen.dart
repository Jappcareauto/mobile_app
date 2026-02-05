import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'dart:io';

import 'package:jappcare/features/chat/ui/chat/controllers/chat_details_controller.dart';

class ImagePreviewScreen extends StatefulWidget {
  final String imagePath;

  const ImagePreviewScreen({super.key, required this.imagePath});

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  final TextEditingController captionController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Image Display
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ImageComponent(
                        file: File(widget.imagePath),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                // Caption Input Section
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Caption input field
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: TextField(
                            controller: captionController,
                            enabled: !_isSending,
                            decoration: InputDecoration(
                              hintText: 'Add a caption...',
                              hintStyle: const TextStyle(
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
                      const SizedBox(width: 5),
                      // Send button
                      GestureDetector(
                        onTap: _isSending ? null : _sendImage,
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isSending
                                ? Colors.grey
                                : Get.theme.primaryColor,
                          ),
                          child: _isSending
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(
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
            // Loading overlay
            if (_isSending)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendImage() async {
    final caption = captionController.text.trim();

    setState(() {
      _isSending = true;
    });

    try {
      // Get the chat controller and send the image
      final chatController = Get.find<ChatDetailsController>();
      await chatController.sendImageMessage(widget.imagePath, caption);

      // Go back to chat screen using Navigator
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send image. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
