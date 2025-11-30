import 'package:flutter/material.dart';

class CreditCard {
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String cardType;
  final Color cardColor;
  final Color textColor;

  CreditCard({
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cardType,
    required this.cardColor,
    this.textColor = Colors.white,
  });
}
