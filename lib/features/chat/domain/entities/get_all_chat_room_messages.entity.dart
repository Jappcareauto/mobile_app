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
    required List<ChatMessageEntity> data,
    required Pagination pagination,
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
  final List<Map<String, dynamic>>? mediaUrls; // List of {url, type, name}
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
    this.mediaUrls,
  });

  factory ChatMessageEntity.create({
    required String id,
    required String createdBy,
    required String updatedBy,
    required String createdAt,
    required String updatedAt,
    required String senderId,
    required String content,
    required String chatRoomId,
    required String timestamp,
    required String type,
    String? appointmentId,
    String? sender,
    String? duration,
    String? mediaUrl,
    List<Map<String, dynamic>>? mediaUrls,
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
      mediaUrls: mediaUrls,
    );
  }

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) {
    // Parse mediaUrls array if present
    List<Map<String, dynamic>>? parsedMediaUrls;
    if (json['mediaUrls'] != null) {
      parsedMediaUrls = (json['mediaUrls'] as List)
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }

    return ChatMessageEntity._(
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      senderId: json['senderId'],
      content: json['content'],
      chatRoomId: json['chatRoomId'] ?? json['chatId'] ?? '',
      timestamp: json['timestamp'],
      type: json['type'],
      appointmentId: json['appointmentId'],
      sender: json['sender'],
      duration: json['duration'],
      mediaUrl: json['mediaUrl'],
      mediaUrls: parsedMediaUrls,
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
    data['mediaUrls'] = mediaUrls;
    return data;
  }

  ChatMessageModel toModel() {
    return ChatMessageModel.fromEntity(this);
  }

  bool get isVoiceMessage => type == 'VOICE';
  bool get isTextMessage => type == 'TEXT';
  bool get isImageMessage =>
      type == 'IMAGE' || (type == 'TEXT_AND_OTHERS' && hasMedia);

  /// Check if the message has any media attachments
  bool get hasMedia {
    if (mediaUrls != null && mediaUrls!.isNotEmpty) {
      // Check if any URL in the list is actually valid
      return mediaUrls!
          .any((m) => m['url'] != null && (m['url'] as String).isNotEmpty);
    }
    return mediaUrl != null && mediaUrl!.isNotEmpty;
  }

  /// Get the first media URL (for single image display)
  String? get firstMediaUrl {
    if (mediaUrls != null && mediaUrls!.isNotEmpty) {
      final url = mediaUrls!.first['url'] as String?;
      return (url != null && url.isNotEmpty) ? url : null;
    }
    return (mediaUrl != null && mediaUrl!.isNotEmpty) ? mediaUrl : null;
  }

  /// Get all media URLs as strings (filtering out empty/null values)
  List<String> get allMediaUrls {
    if (mediaUrls != null && mediaUrls!.isNotEmpty) {
      return mediaUrls!
          .map((m) => m['url'] as String?)
          .where((url) => url != null && url.isNotEmpty)
          .cast<String>()
          .toList();
    }
    if (mediaUrl != null && mediaUrl!.isNotEmpty) {
      return [mediaUrl!];
    }
    return [];
  }
}
