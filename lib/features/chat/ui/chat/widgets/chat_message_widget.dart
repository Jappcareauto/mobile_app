import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room_messages.entity.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessageEntity message;

  const ChatMessageWidget({
    super.key,
    required this.message,
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
                // color: Get.theme.primaryColor.withValues(alpha: .2),
                // : isDarkMode
                //     ? Get.theme.scaffoldBackgroundColor
                //         .withValues(alpha: .2)
                //     : Colors.grey.shade200
                color: isSender
                    ? Get.theme.primaryColor.withValues(alpha: .2)
                    : isDarkMode
                        ? Get.theme.scaffoldBackgroundColor
                            .withValues(alpha: .2)
                        : Colors.grey.shade200,
                borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12))
                    .copyWith(
                        bottomLeft: isSender ? const Radius.circular(12) : null,
                        bottomRight:
                            isSender ? null : const Radius.circular(12)),
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Column(
                crossAxisAlignment: isSender
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content,
                    style: TextStyle(
                      color:
                          isSender || isDarkMode ? Colors.black : Colors.black,
                    ),
                  ),
                  if (date != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 4, 4, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            date.substring(11, 16),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
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
}
