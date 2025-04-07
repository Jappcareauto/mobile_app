import '../../domain/core/entities/get_all_activities.dart';

class GetAllActivitiesModel {
  final List<DataModel> data;
  final PaginationModel pagination;

  GetAllActivitiesModel._({
    required this.data,
    required this.pagination,
  });

  factory GetAllActivitiesModel.fromJson(Map<String, dynamic> json) {
    return GetAllActivitiesModel._(
      data:
          List<DataModel>.from(json['data'].map((x) => DataModel.fromJson(x))),
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

  factory GetAllActivitiesModel.fromEntity(GetAllActivities entity) {
    return GetAllActivitiesModel._(
      data:
          List<DataModel>.from(entity.data.map((x) => DataModel.fromEntity(x))),
      pagination: PaginationModel.fromEntity(entity.pagination),
    );
  }

  GetAllActivities toEntity() {
    return GetAllActivities.create(
      data: data.map((x) => x.toEntity()).toList(),
      pagination: pagination.toEntity(),
    );
  }
}

class DataModel {
  final String? name;
  final String? ownerId;
  final LocationModel? location;
  final String? category;
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;
  final String? imageId;
  final String? imageUrl;
  final String? available;
  final bool availability;

  DataModel._({
    required this.name,
    this.ownerId,
    required this.location,
    required this.category,
    required this.id,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    this.imageId,
    this.imageUrl,
    required this.availability,
    this.available,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return DataModel._(
      name: json['name'],
      ownerId: json['ownerId'],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null, // Gestion de la valeur null pour location
      category: json['category'],
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      imageId: json['imageId'],
      imageUrl: json['imageUrl'],
      availability: json['availability'] ?? false,
      available: json['available'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['ownerId'] = ownerId;
    data['location'] = location?.toJson(); // Utiliser l'opérateur null-aware
    data['category'] = category;
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['imageId'] = imageId;
    data['imageUrl'] = imageUrl;
    data['availability'] = availability;
    data['available'] = available;
    return data;
  }

  factory DataModel.fromEntity(Data entity) {
    return DataModel._(
      name: entity.name,
      ownerId: entity.ownerId,
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
      availability: entity.availability,
      available: entity.available,
    );
  }

  Data toEntity() {
    return Data.create(
      name: name,
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
      availability: availability,
      available: available,
    );
  }
}

class LocationModel {
  final String name;
  final double latitude;
  final double longitude;
  final String description;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  LocationModel._({
    required this.name,
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
      name: json['name'],
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
    data['name'] = name;
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
      name: entity.name,
      latitude: entity.latitude.toDouble(),
      longitude: entity.longitude.toDouble(),
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
      name: name,
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
