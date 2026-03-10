import '../../../../../core/exceptions/base_exception.dart';

class AuthentificationException extends BaseException {
  /// When `true`, the user intentionally cancelled the auth flow
  /// (e.g. dismissed the Google / Apple sign-in sheet).
  /// The UI should silently reset without showing an error.
  final bool isCancelled;

  AuthentificationException(super.message, super.statusCode,
      {this.isCancelled = false});
}
