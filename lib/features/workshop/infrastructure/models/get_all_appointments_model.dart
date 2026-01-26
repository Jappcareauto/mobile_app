import 'package:jappcare/core/ui/domain/models/location.model.dart';
import 'package:jappcare/core/ui/domain/models/pagination.model.dart';
import 'package:jappcare/features/chat/infrastructure/models/get_all_chatrooms.model.dart';
import 'package:jappcare/features/garage/infrastructure/models/get_vehicle_list_model.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';
import 'package:jappcare/features/workshop/infrastructure/models/appointment_invoice_model.dart';
import 'package:jappcare/features/workshop/infrastructure/models/get_all_service_center_model.dart';
import 'package:jappcare/features/workshop/infrastructure/models/get_all_services_model.dart';

class GetAllAppointmentsModel {
  final List<AppointmentModel> data;
  final PaginationModel pagination;

  GetAllAppointmentsModel._({
    required this.data,
    required this.pagination,
  });

  factory GetAllAppointmentsModel.fromJson(Map<String, dynamic> json) {
    return GetAllAppointmentsModel._(
      data: List<AppointmentModel>.from(
          json['data'].map((x) => AppointmentModel.fromJson(x))),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['data'] = data
        .map((x) => x.toJson())
        .toList(); // Utilise la propriété `data` de la classe
    json['pagination'] = pagination.toJson();
    return json;
  }

  factory GetAllAppointmentsModel.fromEntity(GetAllAppointments entity) {
    return GetAllAppointmentsModel._(
      data: List<AppointmentModel>.from(
          entity.data.map((x) => AppointmentModel.fromEntity(x))),
      pagination: PaginationModel.fromEntity(entity.pagination),
    );
  }

  GetAllAppointments toEntity() {
    return GetAllAppointments.create(
      data: data.map((x) => x.toEntity()).toList(),
      pagination: pagination.toEntity(),
    );
  }
}

class AppointmentModel {
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final String? status;
  final String? timeOfDay;
  final String date;
  final String locationType;
  final String? note;
  final LocationModel? location;
  final ServiceModel? service;
  final ServiceCenterModel? serviceCenter;
  final VehicleModel? vehicle;
  final ChatRoomModel? chatRoom;
  final String? diagnosesToMake;
  final String? diagnosesMade;
  final AppointmentInvoiceModel? invoice;

  AppointmentModel._({
    required this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.note,
    this.timeOfDay,
    required this.date,
    required this.locationType,
    this.location,
    this.service,
    this.serviceCenter,
    this.vehicle,
    this.chatRoom,
    this.diagnosesToMake,
    this.diagnosesMade,
    this.invoice,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel._(
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      status: json['status'],
      note: json['note'],
      timeOfDay: json['timeOfDay'],
      date: json['date'],
      locationType: json['locationType'],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      service: json['service'] != null
          ? ServiceModel.fromJson({
              ...json['service'],
              'serviceCenterId': json['serviceCenter']?['id']
            })
          : null,
      serviceCenter: json['serviceCenter'] != null
          ? ServiceCenterModel.fromJson(json['serviceCenter'])
          : null,
      vehicle: json['vehicle'] != null
          ? VehicleModel.fromJson({
              ...json['vehicle'],
              'serviceCenterId': json['serviceCenter']?['id']
            })
          : null,
      // chatRoom: json['chatRoom'] != null
      //     ? ChatRoomModel.fromJson(json['chatRoom'])
      //     : null,
      chatRoom: null,
      diagnosesToMake: json['diagnosesToMake'],
      diagnosesMade: json['diagnosesMade'],
      invoice: json['invoice'] != null
          ? AppointmentInvoiceModel.fromJson(json['invoice'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['status'] = status;
    data['note'] = note;
    data['timeOfDay'] = timeOfDay;
    data['date'] = date;
    data['locationType'] = locationType;
    data['location'] = location?.toJson();
    data['service'] = service?.toJson();
    data['serviceCenter'] = serviceCenter?.toJson();
    data['vehicle'] = vehicle?.toJson();
    data['chatRoom'] = chatRoom?.toJson();
    data['diagnosesToMake'] = diagnosesToMake;
    data['diagnosesMade'] = diagnosesMade;
    data['invoice'] = invoice?.toJson();
    return data;
  }

  factory AppointmentModel.fromEntity(AppointmentEntity entity) {
    return AppointmentModel._(
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      status: entity.status,
      note: entity.note,
      timeOfDay: entity.timeOfDay,
      date: entity.date,
      locationType: entity.locationType,
      location: entity.location?.toModel(),
      service: entity.service?.toModel(),
      serviceCenter: entity.serviceCenter?.toModel(),
      vehicle: entity.vehicle?.toModel(),
      chatRoom: entity.chatRoom?.toModel(),
      diagnosesToMake: entity.diagnosesToMake,
      diagnosesMade: entity.diagnosesMade,
      invoice: entity.invoice != null
          ? AppointmentInvoiceModel.fromEntity(entity.invoice!)
          : null,
    );
  }

  AppointmentEntity toEntity() {
    return AppointmentEntity.create(
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      note: note,
      timeOfDay: timeOfDay,
      date: date,
      locationType: locationType,
      location: location?.toEntity(),
      service: service?.toEntity(),
      serviceCenter: serviceCenter?.toEntity(),
      vehicle: vehicle?.toEntity(),
      chatRoom: chatRoom?.toEntity(),
      diagnosesToMake: diagnosesToMake,
      diagnosesMade: diagnosesMade,
      invoice: invoice?.toEntity(),
    );
  }
}
