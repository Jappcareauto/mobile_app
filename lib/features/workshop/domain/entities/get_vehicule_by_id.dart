// import 'package:jappcare/features/garage/infrastructure/models/get_vehicle_list_model.dart';

class VehicleEntity {
  final String name;
  final String description;
  final String garageId;
  final String vin;
  final String registrationNumber;
  final Detail detail;
  final Media media;
  final String imageUrl;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  VehicleEntity._({
    required this.name,
    required this.description,
    required this.garageId,
    required this.vin,
    required this.registrationNumber,
    required this.detail,
    required this.media,
    required this.imageUrl,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VehicleEntity.create({
    required name,
    required description,
    required garageId,
    required vin,
    required registrationNumber,
    required detail,
    required media,
    required imageUrl,
    required id,
    required createdBy,
    required updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic here
    return VehicleEntity._(
      name: name,
      description: description,
      garageId: garageId,
      vin: vin,
      registrationNumber: registrationNumber,
      detail: detail,
      media: media,
      imageUrl: imageUrl,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class Detail {
  final String make;
  final String model;
  final String year;
  final String trim;
  final String transmission;
  final String driveTrain;
  final String power;
  final String bodyType;
  final String vehicleId;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  Detail._({
    required this.make,
    required this.model,
    required this.year,
    required this.trim,
    required this.transmission,
    required this.driveTrain,
    required this.power,
    required this.bodyType,
    required this.vehicleId,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Detail.create({
    required make,
    required model,
    required year,
    required trim,
    required transmission,
    required driveTrain,
    required power,
    required bodyType,
    required vehicleId,
    required id,
    required createdBy,
    required updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic here
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
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class Media {
  final String type;
  final String source;
  final List<Items> items;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  Media._({
    required this.type,
    required this.source,
    required this.items,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Media.create({
    required type,
    required source,
    required items,
    required id,
    required createdBy,
    required updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic here
    return Media._(
      type: type,
      source: source,
      items: items,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class Items {
  final String sourceUrl;
  final String capturedUrl;
  final String type;
  final String mediaId;
  final String fileId;
  final String fileUrl;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  Items._({
    required this.sourceUrl,
    required this.capturedUrl,
    required this.type,
    required this.mediaId,
    required this.fileId,
    required this.fileUrl,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Items.create({
    required sourceUrl,
    required capturedUrl,
    required type,
    required mediaId,
    required fileId,
    required fileUrl,
    required id,
    required createdBy,
    required updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic here
    return Items._(
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
