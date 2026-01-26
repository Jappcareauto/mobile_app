class PaymentConstants {
  static const String paymentBaseUri = '/payment';
  static const String makePaymentPostUri = '/payment';
  static const String payInvoicePostUri = '/payment/invoice';
  static const String payOrderPostUri = '/payment/order';
  static const String getPaymentsUri = '/payment';
}

/// Payment method enum values
class PaymentMethod {
  static const String cash = 'CASH';
  // Other methods commented out for MVP - cash only
  // static const String creditCard = 'CREDIT_CARD';
  // static const String bankTransfer = 'BANK_TRANSFER';
  // static const String mobileMoney = 'MOBILE_MONEY_TRANZAK';
}
