import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/chat/ui/chat/controllers/chat_details_controller.dart';

class VoiceRecordingUI extends StatelessWidget {
  const VoiceRecordingUI({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatDetailsController>();
    final theme = Theme.of(context);

    return Obx(() {
      if (!controller.showVoiceRecordingUI.value) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _buildRecordingIndicator(theme),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildWaveform(controller, theme),
                ),
                const SizedBox(width: 16),
                _buildDuration(controller, theme),
              ],
            ),
            const SizedBox(height: 8),
            _buildInstructions(controller, theme),
          ],
        ),
      );
    });
  }

  Widget _buildRecordingIndicator(ThemeData theme) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.error,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.error.withValues(alpha: 0.3),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildWaveform(ChatDetailsController controller, ThemeData theme) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      child: Obx(() {
        final isRecordingActive = controller.isRecording.value;

        if (!isRecordingActive) {
          return const SizedBox();
        }

        return LinearProgressIndicator(
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
          minHeight: 40,
        );
      }),
    );
  }

  Widget _buildDuration(ChatDetailsController controller, ThemeData theme) {
    return Obx(() => Text(
          controller.recordingDuration.value,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  Widget _buildInstructions(ChatDetailsController controller, ThemeData theme) {
    return Obx(() {
      if (controller.isRecordingLocked.value) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () => controller.stopRecording(),
              icon: const Icon(Icons.send),
              label: const Text('Send'),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            TextButton.icon(
              onPressed: () => controller.stopRecording(cancelled: true),
              icon: const Icon(Icons.delete),
              label: const Text('Cancel'),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.error,
              ),
            ),
          ],
        );
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.arrow_upward, size: 16),
          const SizedBox(width: 8),
          Text(
            'Slide up to lock recording',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(width: 24),
          const Icon(Icons.arrow_forward, size: 16),
          const SizedBox(width: 8),
          Text(
            'Slide right to cancel',
            style: theme.textTheme.bodySmall,
          ),
        ],
      );
    });
  }
}
