import 'package:jappcare/core/ui/domain/models/pagination.model.dart';

import '../../domain/entities/get_all_services.dart';

class GetAllservicesModel {
  final List<ServiceModel> data;
  final PaginationModel pagination;

  GetAllservicesModel._({
    required this.data,
    required this.pagination,
  });

  factory GetAllservicesModel.fromJson(Map<String, dynamic> json) {
    return GetAllservicesModel._(
      data: List<ServiceModel>.from(
          json['data'].map((x) => ServiceModel.fromJson(x))),
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

  factory GetAllservicesModel.fromEntity(GetAllservices entity) {
    return GetAllservicesModel._(
      data: List<ServiceModel>.from(
          entity.data.map((x) => ServiceModel.fromEntity(x))),
      pagination: PaginationModel.fromEntity(entity.pagination),
    );
  }

  GetAllservices toEntity() {
    return GetAllservices.create(
      data: data.map((x) => x.toEntity()).toList(),
      pagination: pagination.toEntity(),
    );
  }
}

class ServiceModel {
  final String title;
  final String? description;
  final String serviceCenterId;
  final String definition;
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;

  ServiceModel._({
    required this.title,
    this.description,
    required this.serviceCenterId,
    required this.definition,
    required this.id,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel._(
      title: json['title'],
      description: json['description'],
      serviceCenterId: json['serviceCenterId'],
      definition: json['definition'],
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['serviceCenterId'] = serviceCenterId;
    data['definition'] = definition;
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory ServiceModel.fromEntity(ServiceEntity entity) {
    return ServiceModel._(
      title: entity.title,
      description: entity.description,
      serviceCenterId: entity.serviceCenterId,
      definition: entity.definition,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  ServiceEntity toEntity() {
    return ServiceEntity.create(
      title: title,
      description: description,
      serviceCenterId: serviceCenterId,
      definition: definition,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
