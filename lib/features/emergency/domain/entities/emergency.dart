class Emergency {

  final String serviceCenterId;
  final String vehicleId;
  final String title;
  final String note;
  final String status;
  final Location location;
  final String id;
  final String createdAt;
  final String updatedAt;
  final String createdBy;
  final String updatedBy;

  Emergency._({
    required this.serviceCenterId,
    required this.vehicleId,
    required this.title,
    required this.note,
    required this.status,
    required this.location,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
  });

  factory Emergency.create({
    required serviceCenterId,
    required vehicleId,
    required title,
    required note,
    required status,
    required location,
    required id,
    required createdAt,
    required updatedAt,
    required createdBy,
    required updatedBy,
  }) {
    // Add any validation or business logic here
    return Emergency._(
      serviceCenterId: serviceCenterId,
      vehicleId: vehicleId,
      title: title,
      note: note,
      status: status,
      location: location,
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      createdBy: createdBy,
      updatedBy: updatedBy,
    );
  }

}
class Location {

  final int latitude;
  final int longitude;
  final String description;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  Location._({
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Location.create({
    required latitude,
    required longitude,
    required description,
    required id,
    required createdBy,
    required updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic here
    return Location._(
      latitude: latitude,
      longitude: longitude,
      description: description,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

}
