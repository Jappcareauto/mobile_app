import 'package:jappcare/features/workshop/domain/entities/get_all_services.entity.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_services_center.entity.dart';

class ServiceCenterServiceEntity {
  final String id;
  final ServiceCenterEntity serviceCenter;
  final ServiceEntity service;
  final String? createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;
  final double? price;
  final double? durationMinutes;
  final bool? available;

  ServiceCenterServiceEntity._({
    required this.id,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.service,
    required this.serviceCenter,
    this.price,
    this.durationMinutes,
    this.available,
  });

  factory ServiceCenterServiceEntity.create(
      {service,
      serviceCenter,
      required id,
      createdBy,
      updatedBy,
      required createdAt,
      required updatedAt,
      price,
      durationMinutes,
      available}) {
    // Add any validation or business logic here
    return ServiceCenterServiceEntity._(
      service: service,
      serviceCenter: serviceCenter,
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
