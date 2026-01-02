import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/chat/domain/entities/chat_list_item.dart';
import 'package:jappcare/features/chat/ui/chat/widgets/recording_waveform_painter.dart';
import 'package:jappcare/features/chat/ui/chat/widgets/chat_appointment_summary.dart';
import 'package:jappcare/features/chat/ui/chat/widgets/image_message_widget.dart';
import 'package:jappcare/features/chat/ui/chat/widgets/payment_method_widget.dart';
import 'package:jappcare/features/chat/ui/chat/controllers/chat_details_controller.dart';
import 'package:jappcare/features/chat/ui/chat/widgets/chat_app_bar.dart';
import 'package:jappcare/features/chat/ui/chat/widgets/voice_message_widget.dart';
import 'package:jappcare/features/profile/ui/profile/widgets/avatar_widget.dart';
import 'widgets/chat_message_widget.dart';

class ChatDetailsScreen extends GetView<ChatDetailsController> {
  const ChatDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: ChatAppBar(
        profileImageUrl: AppImages.avatar,
        username: controller.appointment.serviceCenter?.name ?? '',
      ),
      body: GetBuilder<ChatDetailsController>(
        builder: (controller) {
          return SafeArea(
            child: Column(
              children: [
                // Connection status indicator
                _buildConnectionStatus(),
                Expanded(
                  child: Obx(() {
                    if (controller.loading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      key: const PageStorageKey('chat_messages_list'),
                      controller: controller.scrollController,
                      padding: const EdgeInsets.all(12.0),
                      itemCount: controller.flattenedItems.length +
                          1, // +1 for welcome message
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(20),
                                child: const Text(
                                  'This is the beginning of your conversation with Jappcare AutoShop',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(controller.currentUser?.name ??
                                          'Unknown'),
                                      const SizedBox(width: 5),
                                      const AvatarWidget(
                                          size: 40, canEdit: false),
                                    ],
                                  ),
                                  const ChatAppointmentSummary(),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        }

                        final itemIndex = index - 1;
                        final item = controller.flattenedItems[itemIndex];

                        if (item is DateHeaderItem) {
                          return _buildDateHeader(item.date);
                        } else if (item is MessageItem) {
                          final message = item.message;
                          final isSender =
                              message.senderId == controller.currentUser?.id;

                          if (message.isVoiceMessage) {
                            return VoiceMessageWidget(
                                message: message, isSender: isSender);
                          } else if (message.isImageMessage) {
                            return ImageMessageWidget(
                                message: message, isSender: isSender);
                          } else {
                            return ChatMessageWidget(
                                message: message, isSender: isSender);
                          }
                        }

                        return const SizedBox.shrink();
                      },
                    );
                  }),
                ),
                _buildInputComposer(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildConnectionStatus() {
    return Obx(() {
      final status = controller.connectionStatus.value;

      // Don't show anything when connected (after initial display)
      if (status == WebSocketStatus.connected) {
        return const SizedBox.shrink();
      }

      Color backgroundColor;
      Color textColor;
      String message;
      IconData icon;
      bool showSpinner = false;

      switch (status) {
        case WebSocketStatus.connecting:
          backgroundColor = Colors.orange.shade100;
          textColor = Colors.orange.shade800;
          message = 'Connecting...';
          icon = Icons.sync;
          showSpinner = true;
          break;
        case WebSocketStatus.disconnected:
          backgroundColor = Colors.red.shade100;
          textColor = Colors.red.shade800;
          message = 'Disconnected. Tap to reconnect';
          icon = Icons.cloud_off;
          break;
        case WebSocketStatus.error:
          backgroundColor = Colors.red.shade100;
          textColor = Colors.red.shade800;
          message = 'Connection error. Tap to retry';
          icon = Icons.error_outline;
          break;
        default:
          return const SizedBox.shrink();
      }

      return GestureDetector(
        onTap: status != WebSocketStatus.connecting
            ? () => controller.reconnect()
            : null,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showSpinner)
                SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                )
              else
                Icon(icon, size: 16, color: textColor),
              const SizedBox(width: 8),
              Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDateHeader(String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor.withValues(alpha: .8),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(
            date,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Get.theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Get.theme.scaffoldBackgroundColor,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Obx(
                  () => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: controller.isRecording.value
                        ? _buildRecordingIndicator()
                        : _buildTextInput(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            _buildSendButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordingIndicator() {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(left: 6.0, right: 16.0),
          constraints: const BoxConstraints(minHeight: 48.0),
          child: Row(
            children: [
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
                child: GestureDetector(
                  onTap: controller.cancelRecording,
                  child: InkWell(
                    onTap: controller.cancelRecording,
                    borderRadius: BorderRadius.circular(8.0),
                    splashColor: Colors.white24,
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    // Convert drag position to progress (0.0 to 1.0)
                    final box = context.findRenderObject() as RenderBox;
                    final progress = details.localPosition.dx / box.size.width;
                    controller
                        .updateRecordingLockState(progress.clamp(0.0, 1.0));
                  },
                  child: Container(
                    height: 32,
                    constraints: const BoxConstraints(minWidth: 32.0),
                    margin: const EdgeInsets.only(left: 0.0, right: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Obx(() {
                      final samples = controller.currentWaveformData.value
                              ?.getNormalizedSamples(count: 50) ??
                          List.generate(50, (i) => 0.0 + i / 50.0);
                      return CustomPaint(
                        painter: RecordingWaveformPainter(
                          waveformPoints: samples,
                          progress: 10.0,
                          primaryColor: Get.theme.primaryColor,
                          secondaryColor: Get.theme.primaryColor.withAlpha(150),
                          animationValue: 0.0,
                          isPlaying: false,
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Obx(
                () => Text(
                  controller.recordingDuration.value,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.messageController,
              onSubmitted: controller.sendMessage,
              decoration: const InputDecoration.collapsed(
                hintText: 'Write a message',
              ),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              FluentIcons.image_copy_24_filled,
              size: 24.0,
            ),
            onPressed: controller.pickImage,
          ),
          IconButton(
            icon: const Icon(Icons.mic),
            onPressed: controller.startRecording,
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return Obx(() {
      // Access observables in the Obx build scope for proper reactivity
      final isRecording = controller.isRecording.value;

      return GestureDetector(
        onTap: () {
          final text = controller.messageController.text;

          if (isRecording) {
            controller.stopRecording();
          } else {
            controller.sendMessage(text);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Get.theme.primaryColor,
          ),
          child: Icon(
            isRecording ? Icons.stop : FluentIcons.send_20_filled,
            size: 20.0,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}

void onpenModalPaymentMethod(void Function(String?) onConfirm) {
  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: [
              PaymentMethodeWidget(onConfirm: () {
                onConfirm(null);
              }),
            ],
          ),
        ),
      );
    },
  );
}
