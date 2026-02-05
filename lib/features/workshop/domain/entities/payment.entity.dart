/// Money value object
class MoneyEntity {
  final double amount;
  final String currency;

  const MoneyEntity({
    required this.amount,
    this.currency = 'XAF',
  });
}

/// Payment response entity
class PaymentEntity {
  final String id;
  final MoneyEntity money;
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

  const PaymentEntity({
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
}
