import 'package:jappcare/features/chat/infrastructure/models/send_message.model.dart';

class SendMessageEntity {
  final String? id;
  final String senderId;
  final String content;
  final String chatRoomId;
  final String timestamp;
  final String type;
  final String appointmentId;
  final String? sender;
  final String? duration; // For voice messages

  SendMessageEntity._({
    this.id,
    required this.senderId,
    required this.content,
    required this.chatRoomId,
    required this.timestamp,
    required this.type,
    required this.appointmentId,
    this.sender,
    this.duration,
  });

  factory SendMessageEntity.create({
    id,
    required senderId,
    required content,
    required chatRoomId,
    required timestamp,
    required type,
    required appointmentId,
    sender,
    duration,
  }) {
    // Add any validation or business logic here
    return SendMessageEntity._(
      id: id,
      senderId: senderId,
      content: content,
      chatRoomId: chatRoomId,
      timestamp: timestamp,
      type: type,
      appointmentId: appointmentId,
      sender: sender,
      duration: duration,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderId'] = senderId;
    data['content'] = content;
    data['chatRoomId'] = chatRoomId;
    data['timestamp'] = timestamp;
    data['type'] = type;
    data['appointmentId'] = appointmentId;
    return data;
  }

  SendMessageModel toModel() {
    return SendMessageModel.fromEntity(this);
  }

  bool get isVoiceMessage => type == 'VOICE';
  bool get isTextMessage => type == 'TEXT';
  bool get isImageMessage => type == 'IMAGE';
}
