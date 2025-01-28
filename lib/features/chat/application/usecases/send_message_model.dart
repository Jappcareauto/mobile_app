import '../../domain/entities/send_message.dart';

class SendMessageModel {

  final String senderId;
  final String content;
  final String chatRoomId;
  final String timestamp;
  final String type;
  final String appointmentId;

  SendMessageModel._({
    required this.senderId,
    required this.content,
    required this.chatRoomId,
    required this.timestamp,
    required this.type,
    required this.appointmentId,
  });

  factory SendMessageModel.fromJson(Map<String, dynamic> json) {
    return SendMessageModel._(
      senderId: json['senderId'],
      content: json['content'],
      chatRoomId: json['chatRoomId'],
      timestamp: json['timestamp'],
      type: json['type'],
      appointmentId: json['appointmentId'],
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

  factory SendMessageModel.fromEntity(SendMessage entity) {
    return SendMessageModel._(
      senderId: entity.senderId,
      content: entity.content,
      chatRoomId: entity.chatRoomId,
      timestamp: entity.timestamp,
      type: entity.type,
      appointmentId: entity.appointmentId,
    );
  }

  SendMessage toEntity() {
    return SendMessage.create(
      senderId: senderId,
      content: content,
      chatRoomId: chatRoomId,
      timestamp: timestamp,
      type: type,
      appointmentId: appointmentId,
    );
  }
}
