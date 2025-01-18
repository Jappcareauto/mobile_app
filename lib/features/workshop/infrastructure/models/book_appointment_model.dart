import '../../domain/entities/book_appointment.dart';

class BookAppointmentModel {

  final String date;
  final String locationType;
  final String note;
  final String serviceId;
  final String vehicleId;
  final String status;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  BookAppointmentModel._({
    required this.date,
    required this.locationType,
    required this.note,
    required this.serviceId,
    required this.vehicleId,
    required this.status,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookAppointmentModel.fromJson(Map<String, dynamic> json) {
    return BookAppointmentModel._(
      date: json['date'],
      locationType: json['locationType'],
      note: json['note'],
      serviceId: json['serviceId'],
      vehicleId: json['vehicleId'],
      status: json['status'],
      id: json['id'],
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
    data['note'] = note;
    data['serviceId'] = serviceId;
    data['vehicleId'] = vehicleId;
    data['status'] = status;
    data['id'] = id;
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
      note: entity.note,
      serviceId: entity.serviceId,
      vehicleId: entity.vehicleId,
      status: entity.status,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  BookAppointment toEntity() {
    return BookAppointment.create(
      date: date,
      locationType: locationType,
      note: note,
      serviceId: serviceId,
      vehicleId: vehicleId,
      status: status,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
