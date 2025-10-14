import 'package:jappcare/core/utils/enums.dart';
import 'package:jappcare/features/authentification/application/usecases/phone_command.dart';

class AddPaymentMethodCommand {
  final PaymentMethod type;
  final PhoneCommand? phone;

  AddPaymentMethodCommand(
      {required this.type, this.phone});
}