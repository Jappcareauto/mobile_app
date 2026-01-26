import 'dart:io';
import 'package:dartz/dartz.dart';
import '../core/exceptions/payment_exception.dart';
import '../entities/payment.entity.dart';

abstract class PaymentRepository {
  /// Make a cash payment for an invoice
  /// [invoiceId] - The invoice to pay
  /// [amount] - Payment amount
  /// [currency] - Currency code (default XAF)
  /// [note] - Optional payment note
  /// [receiptFile] - Optional receipt file for proof of payment
  Future<Either<PaymentException, PaymentEntity>> makeCashPayment({
    required String invoiceId,
    required double amount,
    String currency = 'XAF',
    String? note,
    File? receiptFile,
  });

  /// Get payment by ID
  Future<Either<PaymentException, PaymentEntity>> getPaymentById({
    required String paymentId,
  });

  /// Get all payments with optional filters
  Future<Either<PaymentException, List<PaymentEntity>>> getPayments({
    String? invoiceId,
    String? orderId,
  });
}
