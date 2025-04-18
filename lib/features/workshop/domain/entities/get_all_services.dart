import 'package:jappcare/core/ui/domain/entities/pagination.entity.dart';
import 'package:jappcare/features/workshop/infrastructure/models/get_all_services_model.dart';

class GetAllservices {
  final List<ServiceEntity> data;
  final Pagination pagination;

  GetAllservices._({
    required this.data,
    required this.pagination,
  });

  factory GetAllservices.create({
    required data,
    required pagination,
  }) {
    // Add any validation or business logic here
    return GetAllservices._(
      data: data,
      pagination: pagination,
    );
  }
}

class ServiceEntity {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String title;
  final String? description;
  final String? serviceCenterId;
  final String definition;

  ServiceEntity._({
    required this.title,
    this.description,
    this.serviceCenterId,
    required this.definition,
    required this.id,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceEntity.create({
    required title,
    required description,
    serviceCenterId,
    required definition,
    required id,
    required createdBy,
    required updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic here
    return ServiceEntity._(
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

  ServiceModel toModel() {
    return ServiceModel.fromEntity(this);
  }
}
