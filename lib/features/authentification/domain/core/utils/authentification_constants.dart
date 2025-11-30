//Don't translate me
class AuthentificationConstants {
  static const String featureName = 'authentification';
  static const String featureVersion = '1.0.0';

  // Add other constants here
  static const String loginPostUri = '/auth/login';
  static const String googleLoginPostUri = '/auth/oauth2/google/login';
  static const String googleLoginPostUri2 = '/auth/oauth2/google/login2';
  static const String googleSignUpPostUri = '/auth/oauth2/google/signup';
  static const String registerPostUri = '/auth/register';
  static const String verifyEmailPostUri = '/auth/verify';
  static const String resendOtpPostUri = '/auth/register/verify-resend';
  static const String forgotPasswordPostUri = '/auth/forgot-password';
  static const String resetPasswordPostUri = '/auth/reset-password';
}
