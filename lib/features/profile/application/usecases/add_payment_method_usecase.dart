//Don't translate me
import 'package:jappcare/features/profile/application/command/add_payment_method_command.dart';

import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/profile_exception.dart';
import '../../domain/repositories/profile_repository.dart';

class AddPaymentMethodUseCase {
  final ProfileRepository repository;

  AddPaymentMethodUseCase(this.repository);

  Future<Either<ProfileException, String>> call(
      AddPaymentMethodCommand command) async {
    return await repository.addPaymentMethod(
      type: command.type,
      phone: command.phone,
    );
  }
}
