import '../../domain/entities/get_vehicle_list.dart';

class GetVehicleListModel {
  final String garageId;
  final String name;
  final String? description;
  final String vin;
  final DetailModel? detail;
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;

  GetVehicleListModel._({
    required this.garageId,
    required this.name,
    this.description,
    required this.vin,
    this.detail,
    required this.id,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetVehicleListModel.fromJson(Map<String, dynamic> json) {
    return GetVehicleListModel._(
      garageId: json['garageId'],
      name: json['name'],
      description: json['description'],
      vin: json['vin'],
      detail:
          json['detail'] != null ? DetailModel.fromJson(json['detail']) : null,
      id: json['id'],
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
    if (description != null) {
      data['description'] = description;
    }
    data['vin'] = vin;
    data['detail'] = detail?.toJson();
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

  factory GetVehicleListModel.fromEntity(GetVehicleList entity) {
    return GetVehicleListModel._(
      garageId: entity.garageId,
      name: entity.name,
      description: entity.description,
      vin: entity.vin,
      detail:
          entity.detail != null ? DetailModel.fromEntity(entity.detail!) : null,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  GetVehicleList toEntity() {
    return GetVehicleList.create(
      garageId: garageId,
      name: name,
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
  final String vehicleId;
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
    required this.vehicleId,
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
