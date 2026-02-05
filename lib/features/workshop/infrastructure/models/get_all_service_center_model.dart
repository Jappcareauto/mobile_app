import 'package:jappcare/core/ui/domain/models/location.model.dart';
import 'package:jappcare/features/workshop/infrastructure/models/get_all_services_model.dart';

import '../../domain/entities/get_all_services_center.entity.dart';
import '../../../../core/ui/domain/models/pagination.model.dart';

class GetAllServicesCenterModel {
  final List<ServiceCenterModel> data;
  final PaginationModel pagination;

  GetAllServicesCenterModel._({
    required this.data,
    required this.pagination,
  });

  factory GetAllServicesCenterModel.fromJson(Map<String, dynamic> json) {
    return GetAllServicesCenterModel._(
      data: List<ServiceCenterModel>.from(
          json['data'].map((x) => ServiceCenterModel.fromJson(x))),
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'])
          : PaginationModel.empty(),
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

  factory GetAllServicesCenterModel.fromEntity(
      GetAllServiceCenterEntity entity) {
    return GetAllServicesCenterModel._(
      data: List<ServiceCenterModel>.from(
          entity.data.map((x) => ServiceCenterModel.fromEntity(x))),
      pagination: PaginationModel.fromEntity(entity.pagination),
    );
  }

  GetAllServiceCenterEntity toEntity() {
    return GetAllServiceCenterEntity.create(
      data: data.map((x) => x.toEntity()).toList(),
      pagination: pagination.toEntity(),
    );
  }
}

class ServiceCenterModel {
  final DataModel data;

  ServiceCenterModel._({
    required this.data,
  });

  factory ServiceCenterModel.fromJson(Map<String, dynamic> json) {
    return ServiceCenterModel._(
      data: DataModel.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['data'] = data.toJson();
    return json;
  }

  factory ServiceCenterModel.fromEntity(ServiceCenterEntity entity) {
    return ServiceCenterModel._(
      data: DataModel.fromEntity(entity),
    );
  }

  ServiceCenterEntity toEntity() {
    return ServiceCenterEntity.create(
      name: data.name,
      services: data.services?.map((e) => e.toEntity()).toList(),
      ownerId: data.ownerId,
      location: data.location?.toEntity(),
      category: data.category,
      id: data.id,
      createdBy: data.createdBy,
      updatedBy: data.updatedBy,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      imageId: data.imageId,
      imageUrl: data.imageUrl,
      available: data.available,
    );
  }
}

class DataModel {
  final String? name;
  final String? ownerId;
  final LocationModel? location;
  final List<ServiceModel>? services;
  final String? category;
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final String? imageId;
  final String? imageUrl;
  final bool? available;

  DataModel._({
    required this.name,
    this.ownerId,
    this.services,
    required this.location,
    required this.category,
    required this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.imageId,
    this.imageUrl,
    this.available,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    print('DataModel.fromJson - raw json: $json');
    print('DataModel.fromJson - id field: ${json['id']}');
    return DataModel._(
      name: json['name'],
      ownerId: json['ownerId'],
      services: json['services'] != null
          ? (json['services'] as List)
              .map((e) => ServiceModel.fromJson(e))
              .toList()
          : null,
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null, // Gestion de la valeur null pour location
      category: json['category'],
      id: json['id'] ?? '',
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      imageId: json['imageId'],
      imageUrl: json['imageUrl'],
      available: json['available'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['ownerId'] = ownerId;
    data['services'] = services
        ?.map((e) => e.toJson())
        .toList(); // Utiliser l'opérateur null-aware
    data['location'] = location?.toJson(); // Utiliser l'opérateur null-aware
    data['category'] = category;
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['imageId'] = imageId;
    data['imageUrl'] = imageUrl;
    data['available'] = available;
    return data;
  }

  factory DataModel.fromEntity(ServiceCenterEntity entity) {
    return DataModel._(
      name: entity.name,
      ownerId: entity.ownerId,
      services:
          entity.services?.map((e) => ServiceModel.fromEntity(e)).toList(),
      location: entity.location != null
          ? LocationModel.fromEntity(entity.location!)
          : null, // Si location est null, on le laisse null
      category: entity.category,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      imageId: entity.imageId,
      imageUrl: entity.imageUrl,
      available: entity.available,
    );
  }

  ServiceCenterEntity toEntity() {
    return ServiceCenterEntity.create(
      name: name,
      services: services?.map((e) => e.toEntity()).toList(),
      ownerId: ownerId,
      location: location?.toEntity(),
      category: category,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      imageId: imageId,
      imageUrl: imageUrl,
      available: available,
    );
  }
}
