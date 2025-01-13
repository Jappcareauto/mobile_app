import '../../infrastructure/models/location_model.dart';
class GetGarageByOwnerId {
  final String name;
  final String ownerId;
  final LocationModel? location; // Changement ici
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
    required String name,
    required String ownerId,
    LocationModel? location, // Changement ici
    required String id,
    String? createdBy,
    String? updatedBy,
    required String createdAt,
    required String updatedAt,
  }) {
    // Ajout de la logique métier ou des validations ici, si nécessaire
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
