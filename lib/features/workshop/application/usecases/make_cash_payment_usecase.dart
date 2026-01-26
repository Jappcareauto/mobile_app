import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/payment_exception.dart';
import '../../domain/entities/payment.entity.dart';
import '../../domain/repositories/payment_repository.dart';

class MakeCashPaymentCommand {
  final String invoiceId;
  final double amount;
  final String currency;
  final String? note;
  final File? receiptFile;

  MakeCashPaymentCommand({
    required this.invoiceId,
    required this.amount,
    this.currency = 'XAF',
    this.note,
    this.receiptFile,
  });
}

class MakeCashPaymentUseCase {
  final PaymentRepository _repository;

  MakeCashPaymentUseCase(this._repository);

  Future<Either<PaymentException, PaymentEntity>> call(
      MakeCashPaymentCommand command) async {
    return await _repository.makeCashPayment(
      invoiceId: command.invoiceId,
      amount: command.amount,
      currency: command.currency,
      note: command.note,
      receiptFile: command.receiptFile,
    );
  }
}
