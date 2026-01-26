import 'package:jappcare/features/workshop/domain/entities/appointment_invoice.entity.dart';

/// Model for mapping invoice JSON to/from AppointmentInvoiceEntity
class AppointmentInvoiceModel {
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final String? number;
  final String? diagnosedIssue;
  final String? repairedMade;
  final InvoiceMoneyModel? money;
  final String? status;
  final String? dueDate;
  final String? paidDate;
  final String? issueDate;
  final String? appointmentId;
  final String? serviceCenterId;
  final String? serviceCenterOwnerId;
  final String? garageOwnerId;
  final String? serviceId;
  final String? vehicleId;
  final InvoiceUserModel? billedFromUser;
  final InvoiceUserModel? billedToUser;
  final List<InvoiceItemModel>? items;
  final double? totalPaid;
  final double? remainingBalance;

  AppointmentInvoiceModel._({
    required this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.number,
    this.diagnosedIssue,
    this.repairedMade,
    this.money,
    this.status,
    this.dueDate,
    this.paidDate,
    this.issueDate,
    this.appointmentId,
    this.serviceCenterId,
    this.serviceCenterOwnerId,
    this.garageOwnerId,
    this.serviceId,
    this.vehicleId,
    this.billedFromUser,
    this.billedToUser,
    this.items,
    this.totalPaid,
    this.remainingBalance,
  });

  factory AppointmentInvoiceModel.fromJson(Map<String, dynamic> json) {
    return AppointmentInvoiceModel._(
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      number: json['number'],
      diagnosedIssue: json['diagnosedIssue'],
      repairedMade: json['repairedMade'],
      money: json['money'] != null
          ? InvoiceMoneyModel.fromJson(json['money'])
          : null,
      status: json['status'],
      dueDate: json['dueDate'],
      paidDate: json['paidDate'],
      issueDate: json['issueDate'],
      appointmentId: json['appointmentId'],
      serviceCenterId: json['serviceCenterId'],
      serviceCenterOwnerId: json['serviceCenterOwnerId'],
      garageOwnerId: json['garageOwnerId'],
      serviceId: json['serviceId'],
      vehicleId: json['vehicleId'],
      billedFromUser: json['billedFromUser'] != null
          ? InvoiceUserModel.fromJson(json['billedFromUser'])
          : null,
      billedToUser: json['billedToUser'] != null
          ? InvoiceUserModel.fromJson(json['billedToUser'])
          : null,
      items: json['items'] != null
          ? List<InvoiceItemModel>.from(
              json['items'].map((x) => InvoiceItemModel.fromJson(x)))
          : null,
      totalPaid: json['totalPaid'] != null
          ? (json['totalPaid'] as num).toDouble()
          : null,
      remainingBalance: json['remainingBalance'] != null
          ? (json['remainingBalance'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'number': number,
      'diagnosedIssue': diagnosedIssue,
      'repairedMade': repairedMade,
      'money': money?.toJson(),
      'status': status,
      'dueDate': dueDate,
      'paidDate': paidDate,
      'issueDate': issueDate,
      'appointmentId': appointmentId,
      'serviceCenterId': serviceCenterId,
      'serviceCenterOwnerId': serviceCenterOwnerId,
      'garageOwnerId': garageOwnerId,
      'serviceId': serviceId,
      'vehicleId': vehicleId,
      'billedFromUser': billedFromUser?.toJson(),
      'billedToUser': billedToUser?.toJson(),
      'items': items?.map((x) => x.toJson()).toList(),
      'totalPaid': totalPaid,
      'remainingBalance': remainingBalance,
    };
  }

  factory AppointmentInvoiceModel.fromEntity(AppointmentInvoiceEntity entity) {
    return AppointmentInvoiceModel._(
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      number: entity.number,
      diagnosedIssue: entity.diagnosedIssue,
      repairedMade: entity.repairedMade,
      money: entity.money != null
          ? InvoiceMoneyModel.fromEntity(entity.money!)
          : null,
      status: entity.status,
      dueDate: entity.dueDate,
      paidDate: entity.paidDate,
      issueDate: entity.issueDate,
      appointmentId: entity.appointmentId,
      serviceCenterId: entity.serviceCenterId,
      serviceCenterOwnerId: entity.serviceCenterOwnerId,
      garageOwnerId: entity.garageOwnerId,
      serviceId: entity.serviceId,
      vehicleId: entity.vehicleId,
      billedFromUser: entity.billedFromUser != null
          ? InvoiceUserModel.fromEntity(entity.billedFromUser!)
          : null,
      billedToUser: entity.billedToUser != null
          ? InvoiceUserModel.fromEntity(entity.billedToUser!)
          : null,
      items: entity.items?.map((x) => InvoiceItemModel.fromEntity(x)).toList(),
      totalPaid: entity.totalPaid,
      remainingBalance: entity.remainingBalance,
    );
  }

  AppointmentInvoiceEntity toEntity() {
    return AppointmentInvoiceEntity.create(
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      number: number,
      diagnosedIssue: diagnosedIssue,
      repairedMade: repairedMade,
      money: money?.toEntity(),
      status: status,
      dueDate: dueDate,
      paidDate: paidDate,
      issueDate: issueDate,
      appointmentId: appointmentId,
      serviceCenterId: serviceCenterId,
      serviceCenterOwnerId: serviceCenterOwnerId,
      garageOwnerId: garageOwnerId,
      serviceId: serviceId,
      vehicleId: vehicleId,
      billedFromUser: billedFromUser?.toEntity(),
      billedToUser: billedToUser?.toEntity(),
      items: items?.map((x) => x.toEntity()).toList(),
      totalPaid: totalPaid,
      remainingBalance: remainingBalance,
    );
  }
}

/// Model for money amount with currency
class InvoiceMoneyModel {
  final double amount;
  final String currency;

  InvoiceMoneyModel._({
    required this.amount,
    required this.currency,
  });

  factory InvoiceMoneyModel.fromJson(Map<String, dynamic> json) {
    return InvoiceMoneyModel._(
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] ?? 'XAF',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }

  factory InvoiceMoneyModel.fromEntity(InvoiceMoneyEntity entity) {
    return InvoiceMoneyModel._(
      amount: entity.amount,
      currency: entity.currency,
    );
  }

  InvoiceMoneyEntity toEntity() {
    return InvoiceMoneyEntity.create(
      amount: amount,
      currency: currency,
    );
  }
}

/// Model for user in invoice context
class InvoiceUserModel {
  final String id;
  final String? name;
  final String? email;

  InvoiceUserModel._({
    required this.id,
    this.name,
    this.email,
  });

  factory InvoiceUserModel.fromJson(Map<String, dynamic> json) {
    return InvoiceUserModel._(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory InvoiceUserModel.fromEntity(InvoiceUserEntity entity) {
    return InvoiceUserModel._(
      id: entity.id,
      name: entity.name,
      email: entity.email,
    );
  }

  InvoiceUserEntity toEntity() {
    return InvoiceUserEntity.create(
      id: id,
      name: name,
      email: email,
    );
  }
}

/// Model for invoice item
class InvoiceItemModel {
  final String id;
  final String name;
  final double price;
  final int quantity;

  InvoiceItemModel._({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory InvoiceItemModel.fromJson(Map<String, dynamic> json) {
    return InvoiceItemModel._(
      id: json['id'],
      name: json['name'] ?? '',
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  factory InvoiceItemModel.fromEntity(InvoiceItemEntity entity) {
    return InvoiceItemModel._(
      id: entity.id,
      name: entity.name,
      price: entity.price,
      quantity: entity.quantity,
    );
  }

  InvoiceItemEntity toEntity() {
    return InvoiceItemEntity.create(
      id: id,
      name: name,
      price: price,
      quantity: quantity,
    );
  }
}
