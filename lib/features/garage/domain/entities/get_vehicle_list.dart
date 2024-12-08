class Vehicle {
  final String garageId;
  final String name;
  final String? imageUrl;
  final String? description;
  final String vin;
  final Detail? detail;
  final String id;
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
    this.detail,
    required this.id,
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
    Detail? detail,
    required id,
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
      detail: detail,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
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
    required id,
    createdBy,
    updatedBy,
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
