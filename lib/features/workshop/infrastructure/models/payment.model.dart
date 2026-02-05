import '../../domain/entities/payment.entity.dart';

/// Money model for JSON serialization
class MoneyModel {
  final double amount;
  final String currency;

  MoneyModel({
    required this.amount,
    this.currency = 'XAF',
  });

  factory MoneyModel.fromJson(Map<String, dynamic> json) => MoneyModel(
        amount: (json['amount'] as num).toDouble(),
        currency: json['currency'] ?? 'XAF',
      );

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'currency': currency,
      };

  MoneyEntity toEntity() => MoneyEntity(
        amount: amount,
        currency: currency,
      );
}

/// Payment response model
class PaymentModel {
  final String id;
  final MoneyModel money;
  final DateTime paymentDate;
  final String paymentMethod;
  final String paymentMethodName;
  final String? invoiceId;
  final String? orderId;
  final String? appointmentId;
  final String? receiptFileUrl;
  final String? note;
  final double totalAmount;
  final double totalPaid;
  final double remainingBalance;
  final String invoiceStatus;
  final bool fullyPaid;

  PaymentModel({
    required this.id,
    required this.money,
    required this.paymentDate,
    required this.paymentMethod,
    required this.paymentMethodName,
    this.invoiceId,
    this.orderId,
    this.appointmentId,
    this.receiptFileUrl,
    this.note,
    required this.totalAmount,
    required this.totalPaid,
    required this.remainingBalance,
    required this.invoiceStatus,
    required this.fullyPaid,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json['id'],
        money: MoneyModel.fromJson(json['money']),
        paymentDate: DateTime.parse(json['paymentDate']),
        paymentMethod: json['paymentMethod'] ?? 'CASH',
        paymentMethodName: json['paymentMethodName'] ?? 'Cash',
        invoiceId: json['invoiceId'],
        orderId: json['orderId'],
        appointmentId: json['appointmentId'],
        receiptFileUrl: json['receiptFileUrl'],
        note: json['note'],
        totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
        totalPaid: (json['totalPaid'] as num?)?.toDouble() ?? 0.0,
        remainingBalance: (json['remainingBalance'] as num?)?.toDouble() ?? 0.0,
        invoiceStatus: json['invoiceStatus'] ?? 'PENDING',
        fullyPaid: json['fullyPaid'] ?? false,
      );

  PaymentEntity toEntity() => PaymentEntity(
        id: id,
        money: money.toEntity(),
        paymentDate: paymentDate,
        paymentMethod: paymentMethod,
        paymentMethodName: paymentMethodName,
        invoiceId: invoiceId,
        orderId: orderId,
        appointmentId: appointmentId,
        receiptFileUrl: receiptFileUrl,
        note: note,
        totalAmount: totalAmount,
        totalPaid: totalPaid,
        remainingBalance: remainingBalance,
        invoiceStatus: invoiceStatus,
        fullyPaid: fullyPaid,
      );
}
