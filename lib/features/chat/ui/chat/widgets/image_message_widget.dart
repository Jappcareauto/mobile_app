import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room_messages.entity.dart';
import '../widgets/full_screen_image_view.dart';

class ImageMessageWidget extends StatelessWidget {
  final ChatMessageEntity message;
  final bool isSender;

  const ImageMessageWidget({
    super.key,
    required this.message,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final date = DateTime.tryParse(message.timestamp)?.toString();

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
                // maxHeight: MediaQuery.of(context).size.height * 0.45,
              ),
              decoration: BoxDecoration(
                color: isSender
                    ? Color(0xFFFE8F41)
                    : isDarkMode
                        ? Get.theme.scaffoldBackgroundColor
                            .withValues(alpha: .2)
                        : Color(0xFFE0E0E0),
                borderRadius: _getMessageBorderRadius(isSender),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sender name (if not my message)
                  if (!isSender && message.sender != null)
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
                  if (message.mediaUrl != null)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: GestureDetector(
                          onTap: () => _showFullScreenImage(context),
                          // child: Image.memory(
                          //   base64Decode(message.mediaUrl!),
                          //   width: 250,
                          //   height: 200,
                          //   fit: BoxFit.cover,
                          // ),
                          // child: AspectRatio(
                          //   aspectRatio: 4 / 3,
                          child: Image.file(
                            File(message.mediaUrl ?? ""),
                            // base64Decode(message.mediaUrl!),
                            fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                      ),
                    ),
                  // : Container(
                  //     width: 200,
                  //     height: 200,
                  //     color: Colors.grey,
                  //   ),

                  // Caption and timestamp
                  if (message.isImageMessage && message.content.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 4, 12, 2),
                      child: Text(
                        message.content,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),

                  // Timestamp
                  if (date != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            date.substring(11, 16),
                            style: TextStyle(
                              fontSize: 10,
                              color: isSender || isDarkMode
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          )
                        ],
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

  // Helper for consistent border radius
  BorderRadius _getMessageBorderRadius(bool isMyMessage) {
    const radius = Radius.circular(16);
    const zero =
        Radius.circular(4); // Use a slight curve for the pointed corner

    return BorderRadius.only(
      topLeft: radius,
      topRight: radius,
      bottomLeft: isMyMessage ? radius : zero,
      bottomRight: isMyMessage ? zero : radius,
    );
  }

  void _showFullScreenImage(BuildContext context) {
    if (message.mediaUrl != null) {
      Get.to(
        () => FullScreenImageView(
          imageUrl: message.mediaUrl!,
          caption: message.content,
        ),
      );
    }
  }
}
