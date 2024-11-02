import '../../domain/entities/add_vehicle.dart';

class AddVehicleModel {

  final String name;
  final String? description;
  final String garageId;
  final String vin;
  final String? detail;
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final dynamic? createdAt;
  final dynamic? updatedAt;

  AddVehicleModel._({
    required this.name,
    this.description,
    required this.garageId,
    required this.vin,
    this.detail,
    required this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory AddVehicleModel.fromJson(Map<String, dynamic> json) {
    return AddVehicleModel._(
      name: json['name'],
      description: json['description'],
      garageId: json['garageId'],
      vin: json['vin'],
      detail: json['detail'],
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
    if (description != null) { data['description'] = description; }
    data['garageId'] = garageId;
    data['vin'] = vin;
    if (detail != null) { data['detail'] = detail; }
    data['id'] = id;
    if (createdBy != null) { data['createdBy'] = createdBy; }
    if (updatedBy != null) { data['updatedBy'] = updatedBy; }
    if (createdAt != null) { data['createdAt'] = createdAt; }
    if (updatedAt != null) { data['updatedAt'] = updatedAt; }
    return data;
  }

  factory AddVehicleModel.fromEntity(AddVehicle entity) {
    return AddVehicleModel._(
      name: entity.name,
      description: entity.description,
      garageId: entity.garageId,
      vin: entity.vin,
      detail: entity.detail,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  AddVehicle toEntity() {
    return AddVehicle.create(
      name: name,
      description: description,
      garageId: garageId,
      vin: vin,
      detail: detail,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
