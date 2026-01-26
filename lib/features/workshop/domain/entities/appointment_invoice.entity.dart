/// Entity representing an invoice associated with an appointment
class AppointmentInvoiceEntity {
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final String? number;
  final String? diagnosedIssue;
  final String? repairedMade;
  final InvoiceMoneyEntity? money;
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
  final InvoiceUserEntity? billedFromUser;
  final InvoiceUserEntity? billedToUser;
  final List<InvoiceItemEntity>? items;
  final double? totalPaid;
  final double? remainingBalance;

  AppointmentInvoiceEntity._({
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

  factory AppointmentInvoiceEntity.create({
    required String id,
    String? createdBy,
    String? updatedBy,
    String? createdAt,
    String? updatedAt,
    String? number,
    String? diagnosedIssue,
    String? repairedMade,
    InvoiceMoneyEntity? money,
    String? status,
    String? dueDate,
    String? paidDate,
    String? issueDate,
    String? appointmentId,
    String? serviceCenterId,
    String? serviceCenterOwnerId,
    String? garageOwnerId,
    String? serviceId,
    String? vehicleId,
    InvoiceUserEntity? billedFromUser,
    InvoiceUserEntity? billedToUser,
    List<InvoiceItemEntity>? items,
    double? totalPaid,
    double? remainingBalance,
  }) {
    return AppointmentInvoiceEntity._(
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      number: number,
      diagnosedIssue: diagnosedIssue,
      repairedMade: repairedMade,
      money: money,
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
      billedFromUser: billedFromUser,
      billedToUser: billedToUser,
      items: items,
      totalPaid: totalPaid,
      remainingBalance: remainingBalance,
    );
  }

  /// Calculates the total amount from invoice items
  double get totalFromItems {
    if (items == null || items!.isEmpty) return 0;
    return items!.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  /// Formatted status for display
  String get formattedStatus {
    return status?.split('_').map((word) {
          return word.substring(0, 1).toUpperCase() +
              word.substring(1).toLowerCase();
        }).join(' ') ??
        'Unknown';
  }
}

/// Entity representing money amount with currency
class InvoiceMoneyEntity {
  final double amount;
  final String currency;

  InvoiceMoneyEntity._({
    required this.amount,
    required this.currency,
  });

  factory InvoiceMoneyEntity.create({
    required double amount,
    required String currency,
  }) {
    return InvoiceMoneyEntity._(
      amount: amount,
      currency: currency,
    );
  }

  String get formattedAmount {
    return '${amount.toStringAsFixed(0)} $currency';
  }
}

/// Entity representing a user in the invoice context
class InvoiceUserEntity {
  final String id;
  final String? name;
  final String? email;

  InvoiceUserEntity._({
    required this.id,
    this.name,
    this.email,
  });

  factory InvoiceUserEntity.create({
    required String id,
    String? name,
    String? email,
  }) {
    return InvoiceUserEntity._(
      id: id,
      name: name,
      email: email,
    );
  }
}

/// Entity representing an item in the invoice
class InvoiceItemEntity {
  final String id;
  final String name;
  final double price;
  final int quantity;

  InvoiceItemEntity._({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory InvoiceItemEntity.create({
    required String id,
    required String name,
    required double price,
    required int quantity,
  }) {
    return InvoiceItemEntity._(
      id: id,
      name: name,
      price: price,
      quantity: quantity,
    );
  }

  double get total => price * quantity;
}
