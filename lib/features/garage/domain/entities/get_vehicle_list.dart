import 'package:jappcare/features/garage/infrastructure/models/get_vehicle_list_model.dart';

class Vehicle {
  final String? serviceCenterId;
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
  final String? createdAt;
  final String? updatedAt;

  Vehicle._({
    this.serviceCenterId,
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
    this.createdAt,
    this.updatedAt,
  });

  factory Vehicle.create({
    serviceCenterId,
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
    createdAt,
    updatedAt,
  }) {
    // Add any validation or business logic here
    return Vehicle._(
      serviceCenterId: serviceCenterId,
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
  final String? manufacturer;
  final String? manufacturerRegion;
  final String? manufacturerCountry;
  final String? manufacturerPlantCity;
  final String? restraint;
  final String? engineSize;
  final String? engineDescription;
  final String? engineCapacity;
  final String? dimensions;

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
    this.manufacturer,
    this.manufacturerRegion,
    this.manufacturerCountry,
    this.manufacturerPlantCity,
    this.restraint,
    this.engineSize,
    this.engineDescription,
    this.engineCapacity,
    this.dimensions,
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
    manufacturer,
    manufacturerRegion,
    manufacturerCountry,
    manufacturerPlantCity,
    restraint,
    engineSize,
    engineDescription,
    engineCapacity,
    dimensions,
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
      manufacturer: manufacturer,
      manufacturerRegion: manufacturerRegion,
      manufacturerCountry: manufacturerCountry,
      manufacturerPlantCity: manufacturerPlantCity,
      restraint: restraint,
      engineSize: engineSize,
      engineDescription: engineDescription,
      engineCapacity: engineCapacity,
      dimensions: dimensions,
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
  final String? mainItemUrl;
  final List<String>? items;
  final String? source;

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
    this.mainItemUrl,
    this.items,
    this.source,
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
    mainItemUrl,
    items,
    source,
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
      mainItemUrl: mainItemUrl,
      items: items,
      source: source,
    );
  }
}
