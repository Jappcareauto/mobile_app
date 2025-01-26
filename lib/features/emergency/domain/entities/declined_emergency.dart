import 'package:jappcare/features/emergency/domain/entities/emergency.dart';

class DeclinedEmergency {

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

  DeclinedEmergency._({
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

  factory DeclinedEmergency.create({
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
    return DeclinedEmergency._(
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
