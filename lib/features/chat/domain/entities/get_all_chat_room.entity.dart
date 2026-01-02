import 'package:jappcare/core/ui/domain/entities/pagination.entity.dart';
import 'package:jappcare/features/chat/infrastructure/models/get_all_chatrooms.model.dart';

class GetAllChatRoomsEntity {
  final List<ChatRoomEntity> data;
  final Pagination pagination;

  GetAllChatRoomsEntity._({
    required this.data,
    required this.pagination,
  });

  factory GetAllChatRoomsEntity.create({
    required data,
    required pagination,
  }) {
    // Add any validation or business logic here
    return GetAllChatRoomsEntity._(
      data: data,
      pagination: pagination,
    );
  }
}

class ChatRoomEntity {
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final String name;
  final dynamic appointmentDTO;
  final dynamic participantIds;

  ChatRoomEntity._({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    required this.name,
    this.appointmentDTO,
    this.participantIds,
  });

  factory ChatRoomEntity.create({
    required String id,
    String? createdBy,
    String? updatedBy,
    String? createdAt,
    String? updatedAt,
    required String name,
    dynamic appointmentDTO,
    dynamic participantIds,
  }) {
    // Add any validation or business logic here
    return ChatRoomEntity._(
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
  ChatRoomModel toModel() {
    return ChatRoomModel.fromEntity(this);
  }
}
