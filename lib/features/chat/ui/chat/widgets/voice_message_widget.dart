import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room_messages.entity.dart';
import 'package:jappcare/features/chat/ui/chat/controllers/chat_details_controller.dart';

class VoiceMessageWidget extends StatelessWidget {
  final ChatMessageEntity message;
  final bool isSender;

  const VoiceMessageWidget({
    super.key,
    required this.message,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    // Get your controller instance
    final controller = Get.find<ChatDetailsController>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final date = DateTime.tryParse(message.timestamp)?.toString();
    // Display the widget using similar styling as your image message bubble
    return Obx(() {
      final isActive = controller.isMessageActive(message.id);
      final isPlaying = isActive && controller.isPlaying.value;
      final icon =
          isPlaying ? FluentIcons.pause_20_filled : FluentIcons.play_20_filled;

      // Determine position and duration based on active state
      final currentPosition =
          isActive ? controller.currentPosition.value : Duration.zero;
      final totalDuration = isActive
          ? controller.totalDuration.value
          : Duration(seconds: 10); // Use a default/saved duration

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
                  // minWidth: 150,
                ),
                padding: const EdgeInsets.fromLTRB(0, 12, 12, 6),
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
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        // Play/Pause Button
                        IconButton(
                          icon: Icon(icon,
                              color: isSender ? Colors.white : Colors.black),
                          onPressed: () => controller.togglePlayPause(
                            message.id,
                            message
                                .mediaUrl!, // Pass the unique message ID and URL
                          ),
                        ),

                        // Progress Slider
                        Expanded(
                          child: Column(
                            spacing: 8,
                            children: [
                              Slider(
                                padding: EdgeInsets.zero,
                                min: 0,
                                max: totalDuration.inMilliseconds.toDouble(),
                                value: currentPosition.inMilliseconds
                                    .toDouble()
                                    .clamp(
                                        0,
                                        totalDuration.inMilliseconds
                                            .toDouble()),
                                onChanged: (value) {
                                  if (isActive) {
                                    controller.seekToPosition(value);
                                  }
                                },
                                activeColor:
                                    isSender ? Colors.white : Colors.black,
                                inactiveColor:
                                    isSender ? Colors.white54 : Colors.grey,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Time Display
                                    Text(
                                      controller.formatVoiceMessageDuration(
                                          totalDuration - currentPosition),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: isSender
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    ),
                                    if (date != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                  ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Timestamp
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
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
