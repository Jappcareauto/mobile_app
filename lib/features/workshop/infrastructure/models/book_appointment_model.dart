import 'package:jappcare/core/ui/domain/models/location.model.dart';

import '../../domain/entities/book_appointment.dart';

class BookAppointmentModel {
  final String date;
  final String locationType;
  final LocationModel? location;
  final String note;
  final String serviceId;
  final String vehicleId;
  final String status;
  final String id;
  final String timeOfDay;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  BookAppointmentModel._({
    required this.date,
    required this.locationType,
    this.location,
    required this.note,
    required this.serviceId,
    required this.vehicleId,
    required this.status,
    required this.id,
    required this.timeOfDay,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookAppointmentModel.fromJson(Map<String, dynamic> json) {
    return BookAppointmentModel._(
      date: json['date'],
      locationType: json['locationType'],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      note: json['note'],
      serviceId: json['serviceId'],
      vehicleId: json['vehicleId'],
      status: json['status'],
      id: json['id'],
      timeOfDay: json['timeOfDay'] ?? "MORNING",
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['locationType'] = locationType;
    data['location'] = location?.toJson();
    data['note'] = note;
    data['serviceId'] = serviceId;
    data['vehicleId'] = vehicleId;
    data['status'] = status;
    data['id'] = id;
    data['timeOfDay'] = timeOfDay;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory BookAppointmentModel.fromEntity(BookAppointment entity) {
    return BookAppointmentModel._(
      date: entity.date,
      locationType: entity.locationType,
      location: entity.location?.toModel(),
      note: entity.note,
      serviceId: entity.serviceId,
      vehicleId: entity.vehicleId,
      status: entity.status,
      id: entity.id,
      timeOfDay: entity.timeOfDay,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  BookAppointment toEntity() {
    return BookAppointment.create(
      date: date,
      location: location?.toEntity(),
      locationType: locationType,
      note: note,
      serviceId: serviceId,
      vehicleId: vehicleId,
      status: status,
      id: id,
      timeOfDay: timeOfDay,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
