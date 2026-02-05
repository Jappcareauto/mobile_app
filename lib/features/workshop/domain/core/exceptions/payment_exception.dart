import 'package:jappcare/core/exceptions/base_exception.dart';

class PaymentException extends BaseException {
  PaymentException(super.message, super.statusCode);
}
