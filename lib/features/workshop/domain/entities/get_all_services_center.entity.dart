import 'package:jappcare/core/ui/domain/entities/location.entity.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_services.entity.dart';

import '../../../../core/ui/domain/entities/pagination.entity.dart';

class GetAllServiceCenterEntity {
  final List<ServiceCenterEntity> data;
  final Pagination pagination;

  GetAllServiceCenterEntity._({
    required this.data,
    required this.pagination,
  });

  factory GetAllServiceCenterEntity.create({
    required data,
    required pagination,
  }) {
    // Add any validation or business logic here
    return GetAllServiceCenterEntity._(
      data: data,
      pagination: pagination,
    );
  }
}

class ServiceCenterEntity {
  final String? name;
  final String? ownerId;
  final LocationEntity? location;
  final List<ServiceEntity>? services;
  final String? category;
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;
  final String? imageId;
  final String? imageUrl;
  final bool? available;

  ServiceCenterEntity._({
    required this.name,
    this.ownerId,
    this.services,
    required this.location,
    required this.category,
    required this.id,
    this.createdBy,
    this.updatedBy,
    this.imageId,
    this.imageUrl,
    this.available,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceCenterEntity.create(
      {required name,
      required ownerId,
      services,
      required location,
      required category,
      required id,
      required createdBy,
      required updatedBy,
      required createdAt,
      required updatedAt,
      required imageId,
      required imageUrl,
      available}) {
    // Add any validation or business logic here
    return ServiceCenterEntity._(
      name: name,
      ownerId: ownerId,
      services: services,
      location: location,
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
