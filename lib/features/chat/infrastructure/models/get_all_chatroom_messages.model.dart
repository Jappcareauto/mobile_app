import 'package:jappcare/core/ui/domain/models/pagination.model.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room_messages.entity.dart';

class GetAllChatRoomMessagesModel {
  final List<ChatMessageModel> messages;
  final PaginationModel pagination;

  GetAllChatRoomMessagesModel._({
    required this.messages,
    required this.pagination,
  });

  factory GetAllChatRoomMessagesModel.fromJson(Map<String, dynamic> json) {
    return GetAllChatRoomMessagesModel._(
      messages: List<ChatMessageModel>.from(
          json['data'].map((x) => ChatMessageModel.fromJson(x))),
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'])
          : PaginationModel.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['data'] = messages
        .map((x) => x.toJson())
        .toList(); // Utilise la propriété `data` de la classe
    json['pagination'] = pagination.toJson();
    return json;
  }

  factory GetAllChatRoomMessagesModel.fromEntity(
      GetAllChatRoomMessagesEntity entity) {
    return GetAllChatRoomMessagesModel._(
      messages: List<ChatMessageModel>.from(
          entity.data.map((x) => ChatMessageModel.fromEntity(x))),
      pagination: PaginationModel.fromEntity(entity.pagination),
    );
  }

  GetAllChatRoomMessagesEntity toEntity() {
    return GetAllChatRoomMessagesEntity.create(
      data: messages.map((x) => x.toEntity()).toList(),
      pagination: pagination.toEntity(),
    );
  }
}

class ChatMessageModel {
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final String senderId;
  final String content;
  final String chatRoomId;
  final String timestamp;
  final String type;
  final String? appointmentId;
  final String? mediaUrl;
  final List<dynamic>? mediaUrls;
  final String? duration;

  ChatMessageModel._({
    required this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    required this.senderId,
    required this.content,
    required this.chatRoomId,
    required this.timestamp,
    required this.type,
    this.appointmentId,
    this.mediaUrl,
    this.mediaUrls,
    this.duration,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel._(
      id: json['id'] ?? '',
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      senderId: json['senderId'] ?? '',
      content: json['content'] ?? '',
      chatRoomId: json['chatId'] ?? json['chatRoomId'] ?? '',
      timestamp: json['timestamp']?.toString() ?? '',
      type: json['type'] ?? 'TEXT',
      appointmentId: json['appointmentId'],
      mediaUrl: json['mediaUrl'],
      mediaUrls: json['mediaUrls'],
      duration: json['duration'],
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
    data['mediaUrl'] = mediaUrl;
    data['duration'] = duration;
    return data;
  }

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) {
    return ChatMessageModel._(
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      senderId: entity.senderId,
      content: entity.content,
      chatRoomId: entity.chatRoomId,
      timestamp: entity.timestamp,
      type: entity.type,
      appointmentId: entity.appointmentId,
      mediaUrl: entity.mediaUrl,
      mediaUrls: entity.mediaUrls,
      duration: entity.duration,
    );
  }

  ChatMessageEntity toEntity() {
    // Parse mediaUrls to proper format
    List<Map<String, dynamic>>? parsedMediaUrls;
    if (mediaUrls != null) {
      parsedMediaUrls = mediaUrls!
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    }

    return ChatMessageEntity.create(
      id: id,
      createdBy: createdBy ?? '',
      updatedBy: updatedBy ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
      senderId: senderId,
      content: content,
      chatRoomId: chatRoomId,
      timestamp: timestamp,
      type: type,
      appointmentId: appointmentId,
      mediaUrl: mediaUrl,
      mediaUrls: parsedMediaUrls,
      duration: duration,
    );
  }
}
