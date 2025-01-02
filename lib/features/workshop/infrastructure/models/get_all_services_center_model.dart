import '../../domain/entities/get_all_services_center.dart';

class GetAllServicesCenterModel {

  final List<DataModel> data;
  final PaginationModel pagination;

  GetAllServicesCenterModel._({
    required this.data,
    required this.pagination,
  });

  factory GetAllServicesCenterModel.fromJson(Map<String, dynamic> json) {
    return GetAllServicesCenterModel._(
      data: List<DataModel>.from(json['data'].map((x) => DataModel.fromJson(x))),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['data'] = data.map((x) => x.toJson()).toList(); // Utilise la propriété `data` de la classe
    json['pagination'] = pagination.toJson();
    return json;
  }


  factory GetAllServicesCenterModel.fromEntity(GetAllServicesCenter entity) {
    return GetAllServicesCenterModel._(
      data: List<DataModel>.from(entity.data.map((x) => DataModel.fromEntity(x))),
      pagination: PaginationModel.fromEntity(entity.pagination),
    );
  }

  GetAllServicesCenter toEntity() {
    return GetAllServicesCenter.create(
      data: data.map((x) => x.toEntity()).toList(),
      pagination: pagination.toEntity(),
    );
  }
}
class DataModel {

  final String name;
  final String ownerId;
  final LocationModel location;
  final String category;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  DataModel._({
    required this.name,
    required this.ownerId,
    required this.location,
    required this.category,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel._(
      name: json['name'],
      ownerId: json['ownerId'],
      location: LocationModel.fromJson(json['location']),
      category: json['category'],
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
    data['ownerId'] = ownerId;
    data['location'] = location.toJson();
    data['category'] = category;
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory DataModel.fromEntity(Data entity) {
    return DataModel._(
      name: entity.name,
      ownerId: entity.ownerId,
      location: LocationModel.fromEntity(entity.location),
      category: entity.category,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Data toEntity() {
    return Data.create(
      name: name,
      ownerId: ownerId,
      location: location.toEntity(),
      category: category,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
class LocationModel {

  final int latitude;
  final int longitude;
  final String description;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  LocationModel._({
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel._(
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['description'] = description;
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory LocationModel.fromEntity(Location entity) {
    return LocationModel._(
      latitude: entity.latitude,
      longitude: entity.longitude,
      description: entity.description,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Location toEntity() {
    return Location.create(
      latitude: latitude,
      longitude: longitude,
      description: description,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
class PaginationModel {

  final int page;
  final int size;
  final int totalItems;
  final int totalPages;

  PaginationModel._({
    required this.page,
    required this.size,
    required this.totalItems,
    required this.totalPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel._(
      page: json['page'],
      size: json['size'],
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['size'] = size;
    data['totalItems'] = totalItems;
    data['totalPages'] = totalPages;
    return data;
  }

  factory PaginationModel.fromEntity(Pagination entity) {
    return PaginationModel._(
      page: entity.page,
      size: entity.size,
      totalItems: entity.totalItems,
      totalPages: entity.totalPages,
    );
  }

  Pagination toEntity() {
    return Pagination.create(
      page: page,
      size: size,
      totalItems: totalItems,
      totalPages: totalPages,
    );
  }
}
