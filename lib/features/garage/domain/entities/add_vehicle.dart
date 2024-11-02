class AddVehicle {

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

  AddVehicle._({
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

  factory AddVehicle.create({
    required name,
    description,
    required garageId,
    required vin,
    detail,
    required id,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
  }) {
    // Add any validation or business logic here
    return AddVehicle._(
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
