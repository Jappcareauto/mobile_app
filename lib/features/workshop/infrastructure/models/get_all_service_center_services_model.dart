import 'package:jappcare/features/workshop/domain/entities/get_all_service_center_services.entity.dart';
import 'package:jappcare/features/workshop/domain/entities/service_center_service.entity.dart';
import 'package:jappcare/features/workshop/infrastructure/models/get_all_service_center_model.dart';
import 'package:jappcare/features/workshop/infrastructure/models/get_all_services_model.dart';

import '../../../../core/ui/domain/models/pagination.model.dart';

class GetAllServiceCenterServicesModel {
  final List<ServiceCenterServiceModel> data;
  final PaginationModel pagination;

  GetAllServiceCenterServicesModel._({
    required this.data,
    required this.pagination,
  });

  factory GetAllServiceCenterServicesModel.fromJson(Map<String, dynamic> json) {
    return GetAllServiceCenterServicesModel._(
      data: List<ServiceCenterServiceModel>.from(
          json['data'].map((x) => ServiceCenterServiceModel.fromJson(x))),
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

  factory GetAllServiceCenterServicesModel.fromEntity(
      GetAllServiceCenterServicesEntity entity) {
    return GetAllServiceCenterServicesModel._(
      data: List<ServiceCenterServiceModel>.from(
          entity.data.map((x) => ServiceCenterServiceModel.fromEntity(x))),
      pagination: PaginationModel.fromEntity(entity.pagination),
    );
  }

  GetAllServiceCenterServicesEntity toEntity() {
    return GetAllServiceCenterServicesEntity.create(
      data: data.map((x) => x.toEntity()).toList(),
      pagination: pagination.toEntity(),
    );
  }
}

class ServiceCenterServiceModel {
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;
  final ServiceCenterModel serviceCenter;
  final ServiceModel service;
  final double? price;
  final int? durationMinutes;
  final bool? available;

  ServiceCenterServiceModel._({
    required this.id,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.serviceCenter,
    required this.service,
    this.price,
    this.durationMinutes,
    this.available,
  });

  factory ServiceCenterServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceCenterServiceModel._(
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      service: ServiceModel.fromJson(json['service']),
      serviceCenter: ServiceCenterModel.fromJson(json['serviceCenter']),
      price: json['price'],
      durationMinutes: json['durationMinutes'],
      available: json['available'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['service'] = service.toJson();
    data['serviceCenter'] = serviceCenter.toJson();
    data['price'] = price;
    data['durationMinutes'] = durationMinutes;
    data['available'] = available;
    return data;
  }

  factory ServiceCenterServiceModel.fromEntity(
      ServiceCenterServiceEntity entity) {
    return ServiceCenterServiceModel._(
      service: ServiceModel.fromEntity(entity.service),
      serviceCenter: ServiceCenterModel.fromEntity(entity.serviceCenter),
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      price: entity.price,
      durationMinutes: entity.durationMinutes,
      available: entity.available,
    );
  }

  ServiceCenterServiceEntity toEntity() {
    return ServiceCenterServiceEntity.create(
      service: service.toEntity(),
      serviceCenter: serviceCenter.toEntity(),
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      price: price,
      durationMinutes: durationMinutes,
      available: available,
    );
  }
}
