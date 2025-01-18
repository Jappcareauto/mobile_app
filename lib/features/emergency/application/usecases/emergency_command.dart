import 'package:jappcare/features/emergency/domain/entities/emergency.dart';

class EmergencyCommand {
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
  EmergencyCommand({
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
}