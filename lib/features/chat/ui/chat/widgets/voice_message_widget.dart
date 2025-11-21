import 'dart:math';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room_messages.entity.dart';
import 'package:jappcare/features/chat/ui/chat/controllers/chat_details_controller.dart';

class WaveformPainter extends CustomPainter {
  final List<double> waveformPoints;
  final double progress;
  final Color primaryColor;
  final Color secondaryColor;
  final double animationValue;
  final bool isPlaying;

  WaveformPainter({
    required this.waveformPoints,
    required this.progress,
    required this.primaryColor,
    required this.secondaryColor,
    required this.animationValue,
    required this.isPlaying,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final pointWidth = size.width / waveformPoints.length;
    final middle = size.height / 2;

    for (var i = 0; i < waveformPoints.length; i++) {
      final x = i * pointWidth;
      final normalizedHeight = waveformPoints[i];
      final height = normalizedHeight * size.height;

      // Calculate active/inactive sections based on progress
      final isActive = x / size.width <= progress;
      paint.color = isActive ? primaryColor : secondaryColor;

      // Add animation effect for the currently playing section
      // if (isPlaying && isActive) {
      //   final animationOffset = (animationValue * 0.3);
      //   final adjustedHeight = height * (1.0 + animationOffset);
      //   canvas.drawLine(
      //     Offset(x, middle + (height / 2)),
      //     Offset(x, middle - (height / 2)),
      //     paint,
      //   );
      // } else {
      canvas.drawLine(
        Offset(x, middle + (height / 2)),
        Offset(x, middle - (height / 2)),
        paint,
      );
      // }
    }
  }

  @override
  bool shouldRepaint(WaveformPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.isPlaying != isPlaying;
  }
}

class VoiceMessageWidget extends StatefulWidget {
  final ChatMessageEntity message;
  final bool isSender;

  const VoiceMessageWidget({
    super.key,
    required this.message,
    required this.isSender,
  });

  @override
  State<VoiceMessageWidget> createState() => _VoiceMessageWidgetState();
}

class _VoiceMessageWidgetState extends State<VoiceMessageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isLoading = true;
  List<double> _waveformPoints = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _generateWaveformPoints();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _generateWaveformPoints() {
    // Generate some random-looking but consistent waveform points based on the message ID
    final seed = widget.message.id.hashCode;
    final rng = Random(seed);
    _waveformPoints = List.generate(
      50,
      (index) => (0.3 + rng.nextDouble() * 0.7).clamp(0.0, 1.0),
    );
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatDetailsController>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final date = DateTime.tryParse(widget.message.timestamp)?.toString();

    return Obx(() {
      final isActive = controller.isMessageActive(widget.message.id);
      final isPlaying = isActive && controller.isPlaying.value;
      final icon =
          isPlaying ? FluentIcons.pause_20_filled : FluentIcons.play_20_filled;

      final currentPosition =
          isActive ? controller.currentPosition.value : Duration.zero;
      final totalDuration = isActive
          ? controller.totalDuration.value
          : const Duration(seconds: 10);

      return Align(
        alignment:
            widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.fromLTRB(0, 12, 12, 6),
            decoration: BoxDecoration(
              color: widget.isSender
                  ? const Color(0xFFFE8F41)
                  : isDarkMode
                      ? Get.theme.scaffoldBackgroundColor.withValues(alpha: .2)
                      : const Color(0xFFE0E0E0),
              borderRadius: _getMessageBorderRadius(widget.isSender),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(icon,
                          color: widget.isSender ? Colors.white : Colors.black),
                      onPressed: () => controller.togglePlayPause(
                        widget.message.id,
                        widget.message.mediaUrl!,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_isLoading)
                            const LinearProgressIndicator()
                          else
                            AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                return CustomPaint(
                                  size: const Size(double.infinity, 40),
                                  painter: WaveformPainter(
                                    waveformPoints: _waveformPoints,
                                    progress: currentPosition.inMilliseconds /
                                        totalDuration.inMilliseconds,
                                    primaryColor: widget.isSender
                                        ? Colors.white
                                        : Theme.of(context).primaryColor,
                                    secondaryColor: widget.isSender
                                        ? Colors.white.withValues(alpha: .3)
                                        : Colors.grey.withValues(alpha: .3),
                                    animationValue: _animationController.value,
                                    isPlaying: isPlaying,
                                  ),
                                );
                              },
                            ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.formatVoiceMessageDuration(
                                    totalDuration - currentPosition),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: widget.isSender
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                              if (date != null)
                                Text(
                                  date.substring(11, 16),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: widget.isSender || isDarkMode
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
