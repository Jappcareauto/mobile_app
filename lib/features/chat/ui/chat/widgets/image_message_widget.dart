import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room_messages.entity.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import '../widgets/full_screen_image_view.dart';

class ImageMessageWidget extends StatelessWidget {
  final ChatMessageEntity message;

  const ImageMessageWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isMyMessage =
        message.senderId == Get.find<ProfileController>().userInfos?.id
            ? true
            : false;
    return Align(
      alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment:
              isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 200, minWidth: 200),
              decoration: BoxDecoration(
                color: isMyMessage ? Colors.blue[100] : Colors.grey[200],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16))
                        .copyWith(
                            bottomLeft:
                                isMyMessage ? const Radius.circular(16) : null,
                            bottomRight:
                                isMyMessage ? null : const Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sender name (if not my message)
                  if (!isMyMessage && message.sender != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                      child: Text(
                        message.sender!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),

                  // Image
                  message.mediaUrl != null
                      ? ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                          child: GestureDetector(
                            onTap: () => _showFullScreenImage(context),
                            // child: Image.memory(
                            //   base64Decode(message.mediaUrl!),
                            //   width: 250,
                            //   height: 200,
                            //   fit: BoxFit.cover,
                            // ),
                            child: Image.file(
                              File(message.mediaUrl!),
                              // base64Decode(message.mediaUrl!),
                              width: 200,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      : Container(
                          width: 200,
                          height: 200,
                          color: Colors.grey,
                        ),

                  // Caption and timestamp
                  if (message.isImageMessage && message.content.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                      child: Text(
                        "${message.content} ${isMyMessage ? "mine" : "Other"}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),

                  // Timestamp
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                    child: Text(
                      DateTime.tryParse(message.timestamp)
                          .toString()
                          .substring(11, 16),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
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

  void _showFullScreenImage(BuildContext context) {
    if (message.mediaUrl != null) {
      Get.to(() => FullScreenImageView(
            imageData: base64Decode(message.mediaUrl!),
            // caption: message.caption,
            caption: message.content,
          ));
    }
  }
}
