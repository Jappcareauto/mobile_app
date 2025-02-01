import '../../domain/entities/get_vehicul_by_id.dart';

class GetVehiculByIdModel {

  final String name;
  final String description;
  final String garageId;
  final String vin;
  final String registrationNumber;
  final DetailModel detail;
  final MediaModel media;
  final String imageUrl;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  GetVehiculByIdModel._({
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

  factory GetVehiculByIdModel.fromJson(Map<String, dynamic> json) {
    return GetVehiculByIdModel._(
      name: json['name'],
      description: json['description'],
      garageId: json['garageId'],
      vin: json['vin'],
      registrationNumber: json['registrationNumber'],
      detail: DetailModel.fromJson(json['detail']),
      media: MediaModel.fromJson(json['media']),
      imageUrl: json['imageUrl'],
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['garageId'] = garageId;
    data['vin'] = vin;
    data['registrationNumber'] = registrationNumber;
    data['detail'] = detail.toJson();
    data['media'] = media.toJson();
    data['imageUrl'] = imageUrl;
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory GetVehiculByIdModel.fromEntity(GetVehiculById entity) {
    return GetVehiculByIdModel._(
      name: entity.name,
      description: entity.description,
      garageId: entity.garageId,
      vin: entity.vin,
      registrationNumber: entity.registrationNumber,
      detail: DetailModel.fromEntity(entity.detail),
      media: MediaModel.fromEntity(entity.media),
      imageUrl: entity.imageUrl,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  GetVehiculById toEntity() {
    return GetVehiculById.create(
      name: name,
      description: description,
      garageId: garageId,
      vin: vin,
      registrationNumber: registrationNumber,
      detail: detail.toEntity(),
      media: media.toEntity(),
      imageUrl: imageUrl,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
class DetailModel {

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

  DetailModel._({
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
    data['make'] = make;
    data['model'] = model;
    data['year'] = year;
    data['trim'] = trim;
    data['transmission'] = transmission;
    data['driveTrain'] = driveTrain;
    data['power'] = power;
    data['bodyType'] = bodyType;
    data['vehicleId'] = vehicleId;
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
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

  final String type;
  final String source;
  final List<ItemsModel> items;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  MediaModel._({
    required this.type,
    required this.source,
    required this.items,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel._(
      type: json['type'],
      source: json['source'],
      items: List<ItemsModel>.from(json['items'].map((x) => ItemsModel.fromJson(x))),
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['source'] = source;
    data['items'] = items.map((x) => x.toJson()).toList();
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory MediaModel.fromEntity(Media entity) {
    return MediaModel._(
      type: entity.type,
      source: entity.source,
      items: List<ItemsModel>.from(entity.items.map((x) => ItemsModel.fromEntity(x))),
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Media toEntity() {
    return Media.create(
      type: type,
      source: source,
      items: items.map((x) => x.toEntity()).toList(),
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
class ItemsModel {

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

  ItemsModel._({
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

  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return ItemsModel._(
      sourceUrl: json['sourceUrl'],
      capturedUrl: json['capturedUrl'],
      type: json['type'],
      mediaId: json['mediaId'],
      fileId: json['fileId'],
      fileUrl: json['fileUrl'],
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sourceUrl'] = sourceUrl;
    data['capturedUrl'] = capturedUrl;
    data['type'] = type;
    data['mediaId'] = mediaId;
    data['fileId'] = fileId;
    data['fileUrl'] = fileUrl;
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory ItemsModel.fromEntity(Items entity) {
    return ItemsModel._(
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
  }

  Items toEntity() {
    return Items.create(
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
