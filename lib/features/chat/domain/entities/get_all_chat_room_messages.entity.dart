import 'package:jappcare/core/ui/domain/entities/pagination.entity.dart';
import 'package:jappcare/features/chat/infrastructure/models/get_all_chatroom_messages.model.dart';

class GetAllChatRoomMessagesEntity {
  final List<ChatMessageEntity> data;
  final Pagination pagination;

  GetAllChatRoomMessagesEntity._({
    required this.data,
    required this.pagination,
  });

  factory GetAllChatRoomMessagesEntity.create({
    required data,
    required pagination,
  }) {
    // Add any validation or business logic here
    return GetAllChatRoomMessagesEntity._(
      data: data,
      pagination: pagination,
    );
  }
}

class ChatMessageEntity {
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;
  final String senderId;
  final String content;
  final String chatRoomId;
  final String timestamp;
  final String type;
  final String? appointmentId;
  final String? mediaUrl;
  final String? sender;
  final String? duration; // For voice messages

  ChatMessageEntity._({
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.senderId,
    required this.content,
    required this.chatRoomId,
    required this.timestamp,
    required this.type,
    this.appointmentId,
    this.sender,
    this.duration,
    this.mediaUrl,
  });

  factory ChatMessageEntity.create({
    required id,
    required createdBy,
    required updatedBy,
    required createdAt,
    required updatedAt,
    required senderId,
    required content,
    required chatRoomId,
    required timestamp,
    required type,
    appointmentId,
    sender,
    duration,
    mediaUrl,
  }) {
    // Add any validation or business logic here
    return ChatMessageEntity._(
      id: id,
      createdAt: createdAt,
      createdBy: createdBy,
      updatedAt: updatedAt,
      updatedBy: updatedBy,
      senderId: senderId,
      content: content,
      chatRoomId: chatRoomId,
      timestamp: timestamp,
      type: type,
      appointmentId: appointmentId,
      sender: sender,
      duration: duration,
      mediaUrl: mediaUrl,
    );
  }

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) {
    return ChatMessageEntity._(
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      senderId: json['senderId'],
      content: json['content'],
      chatRoomId: json['chatRoomId'],
      timestamp: json['timestamp'],
      type: json['type'],
      appointmentId: json['appointmentId'],
      sender: json['sender'],
      duration: json['duration'],
      mediaUrl: json['mediaUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['senderId'] = senderId;
    data['content'] = content;
    data['chatRoomId'] = chatRoomId;
    data['timestamp'] = timestamp;
    data['type'] = type;
    data['appointmentId'] = appointmentId;
    data['sender'] = sender;
    data['duration'] = duration;
    data['mediaUrl'] = mediaUrl;
    return data;
  }

  ChatMessageModel toModel() {
    return ChatMessageModel.fromEntity(this);
  }

  bool get isVoiceMessage => type == 'VOICE';
  bool get isTextMessage => type == 'TEXT';
  bool get isImageMessage => type == 'IMAGE';
}
