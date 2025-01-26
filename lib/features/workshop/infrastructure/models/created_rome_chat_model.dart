import '../../domain/entities/created_rome_chat.dart';

class CreatedRomeChatModel {

  final String name;
  final List<String> participantIds;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  CreatedRomeChatModel._({
    required this.name,
    required this.participantIds,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreatedRomeChatModel.fromJson(Map<String, dynamic> json) {
    return CreatedRomeChatModel._(
      name: json['name'],
      participantIds: List<String>.from(json['participantIds']),
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['participantIds'] = participantIds;
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory CreatedRomeChatModel.fromEntity(CreatedRomeChat entity) {
    return CreatedRomeChatModel._(
      name: entity.name,
      participantIds: entity.participantIds,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  CreatedRomeChat toEntity() {
    return CreatedRomeChat.create(
      name: name,
      participantIds: participantIds,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
