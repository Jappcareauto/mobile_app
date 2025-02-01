import '../../domain/entities/get_allservices.dart';

class GetAllservicesModel {

  final List<DataModel> data;
  final PaginationModel pagination;

  GetAllservicesModel._({
    required this.data,
    required this.pagination,
  });

  factory GetAllservicesModel.fromJson(Map<String, dynamic> json) {
    return GetAllservicesModel._(
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

  factory GetAllservicesModel.fromEntity(GetAllservices entity) {
    return GetAllservicesModel._(
      data: List<DataModel>.from(entity.data.map((x) => DataModel.fromEntity(x))),
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
class DataModel {

  final String title;
  final String? description;
  final String serviceCenterId;
  final String definition;
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;

  DataModel._({
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

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel._(
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

  factory DataModel.fromEntity(Data entity) {
    return DataModel._(
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

  Data toEntity() {
    return Data.create(
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
