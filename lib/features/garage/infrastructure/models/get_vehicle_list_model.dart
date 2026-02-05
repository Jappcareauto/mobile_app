import '../../domain/entities/get_vehicle_list.dart';

class VehicleModel {
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final String name;
  final String? description;
  final String? serviceCenterId;
  final String vin;
  final String registrationNumber;
  final String? imageUrl;
  final DetailModel? detail;
  final List<MediaModel?>? media;

  VehicleModel._({
    this.serviceCenterId,
    required this.name,
    this.imageUrl,
    this.description,
    required this.vin,
    required this.registrationNumber,
    this.detail,
    required this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.media,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    // Check if detail exists, otherwise create DetailModel from root-level properties
    DetailModel? detailModel;
    if (json['detail'] != null) {
      detailModel = DetailModel.fromJson(json['detail']);
    } else if (json['make'] != null ||
        json['model'] != null ||
        json['year'] != null) {
      // Create DetailModel from root-level properties for flattened vehicle data
      detailModel = DetailModel.fromFlattenedJson(json);
    }

    return VehicleModel._(
      serviceCenterId: json['serviceCenterId'],
      name: json['name'],
      imageUrl: json['imageUrl'] ?? json['media']?["mainItemUrl"],
      description: json['description'],
      vin: json['vin'] ?? "",
      registrationNumber: json['registrationNumber'] ?? "",
      detail: detailModel,
      id: json['id'],
      media: json['media']?["items"] != null
          ? List.generate(
              json['media']['items'].length,
              (index) => json['media']['items'][index] != null
                  ? MediaModel.fromJson(json['media']['items'][index])
                  : null)
          : null,
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceCenterId'] = serviceCenterId;
    data['name'] = name;
    if (imageUrl != null) {
      data['imageUrl'] = imageUrl;
    }
    if (description != null) {
      data['description'] = description;
    }
    data['vin'] = vin;
    data['detail'] = detail?.toJson();
    data['id'] = id;
    data['media'] = media?.map((e) => e?.toJson()).toList();
    if (createdBy != null) {
      data['createdBy'] = createdBy;
    }
    if (updatedBy != null) {
      data['updatedBy'] = updatedBy;
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory VehicleModel.fromEntity(Vehicle entity) {
    return VehicleModel._(
      serviceCenterId: entity.serviceCenterId,
      name: entity.name,
      imageUrl: entity.imageUrl,
      description: entity.description,
      vin: entity.vin,
      registrationNumber: entity.registrationNumber,
      detail:
          entity.detail != null ? DetailModel.fromEntity(entity.detail!) : null,
      id: entity.id,
      media: entity.media?.map((e) => MediaModel.fromEntity(e!)).toList(),
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Vehicle toEntity() {
    return Vehicle.create(
      serviceCenterId: serviceCenterId,
      name: name,
      imgUrl: imageUrl,
      description: description,
      vin: vin,
      registrationNumber: registrationNumber,
      detail: detail?.toEntity(),
      media: media?.map((e) => e?.toEntity()).toList(),
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class DetailModel {
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;
  final String? make;
  final String? model;
  final String? year;
  final String? trim;
  final String? vehicleType;
  final String? transmission;
  final String? driveTrain;
  final String? power;
  final String? bodyType;
  final String? manufacturer;
  final String? manufacturerRegion;
  final String? manufacturerCountry;
  final String? manufacturerPlantCity;
  final String? restraint;
  final String? engineSize;
  final String? engineDescription;
  final String? engineCapacity;
  final String? dimensions;
  final String? vehicleId;

  DetailModel._({
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

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel._(
      make: json['make'],
      model: json['model'],
      year: json['year'],
      trim: json['trim'],
      transmission: json['transmission'],
      driveTrain: json['driveTrain'],
      power: json['power'],
      bodyType: json['bodyType'],
      vehicleId: json['vehicleId'],
      vehicleType: json['vehicleType'],
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      manufacturer: json['manufacturer'],
      manufacturerRegion: json['manufacturerRegion'],
      manufacturerCountry: json['manufacturerCountry'],
      manufacturerPlantCity: json['manufacturerPlantCity'],
      restraint: json['restraint'],
      engineSize: json['engineSize'],
      engineDescription: json['engineDescription'],
      engineCapacity: json['engineCapacity'],
      dimensions: json['dimensions'],
    );
  }

  /// Creates DetailModel from flattened vehicle JSON where make, model, year
  /// are at root level instead of nested in a detail object
  factory DetailModel.fromFlattenedJson(Map<String, dynamic> json) {
    return DetailModel._(
      make: json['make'],
      model: json['model'],
      year: json['year']?.toString(),
      id: json['id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (make != null) {
      data['make'] = make;
    }
    if (model != null) {
      data['model'] = model;
    }
    if (year != null) {
      data['year'] = year;
    }
    if (trim != null) {
      data['trim'] = trim;
    }
    if (transmission != null) {
      data['transmission'] = transmission;
    }
    if (driveTrain != null) {
      data['driveTrain'] = driveTrain;
    }
    if (power != null) {
      data['power'] = power;
    }
    if (bodyType != null) {
      data['bodyType'] = bodyType;
    }
    data['vehicleId'] = vehicleId;
    if (vehicleType != null) {
      data['vehicleType'] = vehicleType;
    }
    data['id'] = id;
    if (createdBy != null) {
      data['createdBy'] = createdBy;
    }
    if (updatedBy != null) {
      data['updatedBy'] = updatedBy;
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;

    if (manufacturer != null) {
      data['manufacturer'] = manufacturer;
    }
    if (manufacturerRegion != null) {
      data['manufacturerRegion'] = manufacturerRegion;
    }
    if (manufacturerCountry != null) {
      data['manufacturerCountry'] = manufacturerCountry;
    }
    if (manufacturerPlantCity != null) {
      data['manufacturerPlantCity'] = manufacturerPlantCity;
    }
    if (restraint != null) {
      data['restraint'] = restraint;
    }
    if (engineSize != null) {
      data['engineSize'] = engineSize;
    }
    if (engineDescription != null) {
      data['engineDescription'] = engineDescription;
    }
    if (engineCapacity != null) {
      data['engineCapacity'] = engineCapacity;
    }
    if (dimensions != null) {
      data['dimensions'] = dimensions;
    }

    return data;
  }

  factory DetailModel.fromEntity(Detail entity) {
    return DetailModel._(
      make: entity.make,
      model: entity.model,
      year: entity.year,
      trim: entity.trim,
      transmission: entity.transmission,
      driveTrain: entity.driveTrain,
      power: entity.power,
      bodyType: entity.bodyType,
      vehicleId: entity.vehicleId,
      vehicleType: entity.vehicleType,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      manufacturer: entity.manufacturer,
      manufacturerRegion: entity.manufacturerRegion,
      manufacturerCountry: entity.manufacturerCountry,
      manufacturerPlantCity: entity.manufacturerPlantCity,
      restraint: entity.restraint,
      engineSize: entity.engineSize,
      engineDescription: entity.engineDescription,
      engineCapacity: entity.engineCapacity,
      dimensions: entity.dimensions,
    );
  }

  Detail toEntity() {
    return Detail.create(
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

class MediaModel {
  final String? id;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? type;
  final String sourceUrl;
  final String? capturedUrl;
  final String? mediaId;
  final String? fileId;
  final String? fileUrl;
  final String? source;
  final List<String>? items;
  final String? mainItemUrl;

  MediaModel({
    required this.sourceUrl,
    this.capturedUrl,
    this.type,
    this.mediaId,
    this.fileId,
    this.fileUrl,
    this.mainItemUrl,
    this.items,
    this.source,
    this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
        sourceUrl: json["sourceUrl"],
        capturedUrl: json["capturedUrl"],
        type: json["type"],
        mediaId: json["mediaId"],
        fileId: json["fileId"],
        fileUrl: json["fileUrl"],
        id: json["id"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        mainItemUrl: json['mainItemUrl'],
        items: json['items'],
        source: json['source'],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  factory MediaModel.fromEntity(Media entity) => MediaModel(
        sourceUrl: entity.sourceUrl,
        capturedUrl: entity.capturedUrl,
        type: entity.type,
        mediaId: entity.mediaId,
        fileId: entity.fileId,
        fileUrl: entity.fileUrl,
        id: entity.id,
        createdBy: entity.createdBy,
        updatedBy: entity.updatedBy,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        mainItemUrl: entity.mainItemUrl,
        items: entity.items,
        source: entity.source,
      );

  Map<String, dynamic> toJson() => {
        "sourceUrl": sourceUrl,
        "capturedUrl": capturedUrl,
        "type": type,
        "mediaId": mediaId,
        "fileId": fileId,
        "fileUrl": fileUrl,
        "id": id,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "mainItemUrl": mainItemUrl,
        "items": items,
        "source": source
      };

  Media toEntity() => Media.create(
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
      source: source);
}
