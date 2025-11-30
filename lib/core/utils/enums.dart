enum PaymentMethod { orange, mtn, card }

extension PaymentMethodExtension on PaymentMethod {
  String get value => _paymentMethodValues[this] ?? '';

  static const _paymentMethodValues = {
    PaymentMethod.orange: 'ORANGE',
    PaymentMethod.mtn: 'MTN',
    PaymentMethod.card: 'CARD',
  };
}
