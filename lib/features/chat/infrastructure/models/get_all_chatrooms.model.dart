import 'package:jappcare/core/ui/domain/models/pagination.model.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room.entity.dart';

class GetAllChatRoomsModel {
  final List<ChatRoomModel> chatrooms;
  final PaginationModel pagination;

  GetAllChatRoomsModel._({
    required this.chatrooms,
    required this.pagination,
  });

  factory GetAllChatRoomsModel.fromJson(Map<String, dynamic> json) {
    return GetAllChatRoomsModel._(
      chatrooms: List<ChatRoomModel>.from(
          json['data'].map((x) => ChatRoomModel.fromJson(x))),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['data'] = chatrooms
        .map((x) => x.toJson())
        .toList(); // Utilise la propriété `data` de la classe
    json['pagination'] = pagination.toJson();
    return json;
  }

  factory GetAllChatRoomsModel.fromEntity(GetAllChatRoomsEntity entity) {
    return GetAllChatRoomsModel._(
      chatrooms: List<ChatRoomModel>.from(
          entity.data.map((x) => ChatRoomModel.fromEntity(x))),
      pagination: PaginationModel.fromEntity(entity.pagination),
    );
  }

  GetAllChatRoomsEntity toEntity() {
    return GetAllChatRoomsEntity.create(
      data: chatrooms.map((x) => x.toEntity()).toList(),
      pagination: pagination.toEntity(),
    );
  }
}

class ChatRoomModel {
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;
  final String name;
  final String? appointmentDTO;
  final String? participantIds;

  ChatRoomModel._({
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    this.appointmentDTO,
    this.participantIds,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel._(
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      name: json['name'],
      appointmentDTO: json['appointmentDTO'],
      participantIds: json['participantIds'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['name'] = name;
    data['appointmentDTO'] = appointmentDTO;
    data['participantIds'] = participantIds;
    return data;
  }

  factory ChatRoomModel.fromEntity(ChatRoomEntity entity) {
    return ChatRoomModel._(
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      name: entity.name,
      appointmentDTO: entity.appointmentDTO,
      participantIds: entity.participantIds,
    );
  }

  ChatRoomEntity toEntity() {
    return ChatRoomEntity.create(
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      name: name,
      appointmentDTO: appointmentDTO,
      participantIds: participantIds,
    );
  }
}
