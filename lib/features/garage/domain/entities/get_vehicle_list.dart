import 'package:jappcare/features/garage/infrastructure/models/get_vehicle_list_model.dart';

class Vehicle {
  final String garageId;
  final String name;
  final String? imageUrl;
  final String? description;
  final String vin;
  final String registrationNumber;
  final Detail? detail;
  final String id;
  final List<Media?>? media;
  final String? createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;

  Vehicle._({
    required this.garageId,
    required this.name,
    this.description,
    this.imageUrl,
    required this.vin,
    required this.registrationNumber,
    this.detail,
    required this.id,
    this.media,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Vehicle.create({
    required garageId,
    required name,
    String? imgUrl,
    description,
    required vin,
    required registrationNumber,
    Detail? detail,
    required id,
    List<Media?>? media,
    createdBy,
    updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic here
    return Vehicle._(
      garageId: garageId,
      name: name,
      imageUrl: imgUrl,
      description: description,
      vin: vin,
      registrationNumber: registrationNumber,
      detail: detail,
      id: id,
      media: media,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  VehicleModel toModel() {
    return VehicleModel.fromEntity(this);
  }
}

class Detail {
  final String? make;
  final String? model;
  final String? year;
  final String? trim;
  final String? transmission;
  final String? driveTrain;
  final String? power;
  final String? bodyType;
  final String? vehicleId;
  final String? vehicleType;
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;

  Detail._({
    this.make,
    this.model,
    this.year,
    this.trim,
    this.transmission,
    this.driveTrain,
    this.power,
    this.bodyType,
    this.vehicleId,
    this.vehicleType,
    required this.id,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Detail.create({
    make,
    model,
    year,
    trim,
    transmission,
    driveTrain,
    power,
    bodyType,
    vehicleId,
    vehicleType,
    required id,
    createdBy,
    updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic herea
    return Detail._(
      make: make,
      model: model,
      year: year,
      trim: trim,
      transmission: transmission,
      driveTrain: driveTrain,
      power: power,
      bodyType: bodyType,
      vehicleId: vehicleId,
      vehicleType: vehicleType,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class Media {
  final String sourceUrl;
  final String? capturedUrl;
  final String? type;
  final String? mediaId;
  final String? fileId;
  final String? fileUrl;
  final String? id;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Media._({
    required this.sourceUrl,
    this.capturedUrl,
    this.type,
    this.mediaId,
    this.fileId,
    this.fileUrl,
    this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Media.create({
    required sourceUrl,
    capturedUrl,
    type,
    mediaId,
    fileId,
    fileUrl,
    id,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
  }) {
    // Add any validation or business logic here
    return Media._(
      sourceUrl: sourceUrl,
      capturedUrl: capturedUrl,
      type: type,
      mediaId: mediaId,
      fileId: fileId,
      fileUrl: fileUrl,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
