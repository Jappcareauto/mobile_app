import 'package:jappcare/features/workshop/domain/entities/get_all_services.dart';

import '../../../../core/ui/domain/entities/pagination.entity.dart';
import '../../../../core/ui/domain/entities/location.entity.dart';

class GetAllServicesCenter {
  final List<Data> data;
  final Pagination pagination;

  GetAllServicesCenter._({
    required this.data,
    required this.pagination,
  });

  factory GetAllServicesCenter.create({
    required data,
    required pagination,
  }) {
    // Add any validation or business logic here
    return GetAllServicesCenter._(
      data: data,
      pagination: pagination,
    );
  }
}

class Data {
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
  final String? available;
  final bool availability;

  Data._({
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
    required this.availability,
    this.available,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.create(
      {required name,
      required ownerId,
      required services,
      required location,
      required category,
      required id,
      required createdBy,
      required updatedBy,
      required createdAt,
      required updatedAt,
      required imageId,
      required imageUrl,
      required availability,
      required available}) {
    // Add any validation or business logic here
    return Data._(
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
        availability: availability,
        available: available);
  }
}

// class Location {
//   final String name;
//   final double latitude;
//   final double longitude;
//   final String description;
//   final String id;
//   final String createdBy;
//   final String updatedBy;
//   final String createdAt;
//   final String updatedAt;

//   Location._({
//     required this.name,
//     required this.latitude,
//     required this.longitude,
//     required this.description,
//     required this.id,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Location.create({
//     required name,
//     required latitude,
//     required longitude,
//     required description,
//     required id,
//     required createdBy,
//     required updatedBy,
//     required createdAt,
//     required updatedAt,
//   }) {
//     // Add any validation or business logic here
//     return Location._(
//       name: name,
//       latitude: latitude,
//       longitude: longitude,
//       description: description,
//       id: id,
//       createdBy: createdBy,
//       updatedBy: updatedBy,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//     );
//   }
// }
