import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room_messages.entity.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessageEntity message;
  final bool isSender;

  const ChatMessageWidget({
    super.key,
    required this.message,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isSender =
        message.senderId == Get.find<ProfileController>().userInfos?.id
            ? true
            : false;
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
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
              decoration: BoxDecoration(
                color: isSender
                    ? Color(0xFFFE8F41)
                    : isDarkMode
                        ? Get.theme.scaffoldBackgroundColor
                            .withValues(alpha: .2)
                        : Color(0xFFE0E0E0),
                borderRadius: _getMessageBorderRadius(isSender),
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content,
                    style: TextStyle(
                      color:
                          isSender || isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
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
            // Timestamp
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
}
