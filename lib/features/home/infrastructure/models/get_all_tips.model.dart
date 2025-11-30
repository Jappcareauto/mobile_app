import 'package:jappcare/core/ui/domain/models/pagination.model.dart';
import 'package:jappcare/features/home/domain/entities/get_tips_list.entity.dart';

class GetAllTipsModel {
  final List<TipModel> data;
  final PaginationModel pagination;

  GetAllTipsModel._({
    required this.data,
    required this.pagination,
  });

  factory GetAllTipsModel.fromJson(Map<String, dynamic> json) {
    return GetAllTipsModel._(
      data: List<TipModel>.from(
          json['data'].map((x) => TipModel.fromJson(x))),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['data'] = data
        .map((x) => x.toJson())
        .toList(); // Utilise la propriété `data` de la classe
    json['pagination'] = pagination.toJson();
    return json;
  }

  factory GetAllTipsModel.fromEntity(GetAllTips entity) {
    return GetAllTipsModel._(
      data: List<TipModel>.from(
          entity.data.map((x) => TipModel.fromEntity(x))),
      pagination: PaginationModel.fromEntity(entity.pagination),
    );
  }

  GetAllTips toEntity() {
    return GetAllTips.create(
      data: data.map((x) => x.toEntity()).toList(),
      pagination: pagination.toEntity(),
    );
  }
}

class TipModel {
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;
  final String title;
  final String description;
  // final ServiceCenterMode? serviceCenter;

  TipModel._({
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.description
  });

  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel._(
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['title'] = title;
    data['description'] = description;
    return data;
  }

  factory TipModel.fromEntity(TipEntity entity) {
    return TipModel._(
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      title: entity.title,
      description: entity.description,
    );
  }

  TipEntity toEntity() {
    return TipEntity.create(
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      title: title,
      description: description,
    );
  }
}
