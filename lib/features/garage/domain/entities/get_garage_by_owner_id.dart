class GetGarageByOwnerId {

  final String name;
  final String ownerId;
  final String? location;
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;

  GetGarageByOwnerId._({
    required this.name,
    required this.ownerId,
    this.location,
    required this.id,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetGarageByOwnerId.create({
    required name,
    required ownerId,
    location,
    required id,
    createdBy,
    updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic here
    return GetGarageByOwnerId._(
      name: name,
      ownerId: ownerId,
      location: location,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

}
