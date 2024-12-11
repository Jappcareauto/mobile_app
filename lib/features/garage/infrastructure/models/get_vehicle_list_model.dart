import '../../domain/entities/get_vehicle_list.dart';

class VehicleModel {
  final String garageId;
  final String name;
  final String? imageUrl;
  final String? description;
  final String vin;
  final DetailModel? detail;
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;
  final List<MediaModel?>? media;

  VehicleModel._({
    required this.garageId,
    required this.name,
    this.imageUrl,
    this.description,
    required this.vin,
    this.detail,
    required this.id,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    this.media,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel._(
      garageId: json['garageId'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      vin: json['vin'],
      detail:
          json['detail'] != null ? DetailModel.fromJson(json['detail']) : null,
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
    data['garageId'] = garageId;
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
      garageId: entity.garageId,
      name: entity.name,
      imageUrl: entity.imageUrl,
      description: entity.description,
      vin: entity.vin,
      detail:
          entity.detail != null ? DetailModel.fromEntity(entity.detail!) : null,
      id: entity.id,
      media: entity.media?.map((e) => MediaModel.fromEntity(e)).toList(),
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Vehicle toEntity() {
    return Vehicle.create(
      garageId: garageId,
      name: name,
      imgUrl: imageUrl,
      description: description,
      vin: vin,
      detail: detail?.toEntity(),
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class DetailModel {
  final String? make;
  final String? model;
  final String? year;
  final String? trim;
  final String? transmission;
  final String? driveTrain;
  final String? power;
  final String? bodyType;
  final String? vehicleId;
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;

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
    required this.id,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
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
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
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
    data['id'] = id;
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
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
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
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class MediaModel {
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

  MediaModel({
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
      };

}
