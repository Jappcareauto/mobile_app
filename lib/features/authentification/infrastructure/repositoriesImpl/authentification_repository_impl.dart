//Don't translate me
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:jappcare/core/services/deep_link_service.dart';
import 'package:jappcare/features/authentification/application/usecases/phone_command.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/repositories/authentification_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

import '../../domain/entities/login.dart';
import '../../../../core/exceptions/base_exception.dart';
import '../../domain/core/exceptions/authentification_exception.dart';
import '../../domain/core/utils/authentification_constants.dart';
import 'package:dartz/dartz.dart';
import '../models/login_model.dart';
import '../../domain/entities/register.dart';
import '../models/register_model.dart';

import '../../domain/entities/forgot_password.dart';
import '../models/forgot_password_model.dart';

import '../../domain/entities/reset_password.dart';
import '../models/reset_password_model.dart';

import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

// OAuth client ID for iOS app (Google Cloud Console iOS client).
const String _iosClientId =
    "500790497314-m49h2ib7v66eh8mhcf4luh8h9svp3k8d.apps.googleusercontent.com";

// OAuth client ID for backend server token exchange.
const String _serverClientId =
    "500790497314-6gbpppq0khotsi1lo119jdhmle30u37s.apps.googleusercontent.com";

// Guard: google_sign_in v7 requires initialize() to be called EXACTLY ONCE.
// Calling it more than once is explicitly documented as undefined behavior.
bool _googleSignInInitialized = false;

Future<void> _initializeGoogleSignIn() async {
  if (_googleSignInInitialized) return;
  _googleSignInInitialized = true;

  // On iOS the clientId can also be set via GIDClientID in Info.plist;
  // passing it here ensures it takes precedence and is explicit.
  final String? clientId = Platform.isIOS ? _iosClientId : null;
  try {
    debugPrint(
      'GoogleSignIn initialize start: platform=${Platform.operatingSystem}, clientId=${clientId ?? 'null'}, serverClientId=$_serverClientId',
    );
    await _googleSignIn.initialize(
      clientId: clientId,
      serverClientId: _serverClientId,
    );
    debugPrint('GoogleSignIn initialize success');
  } catch (e) {
    // Reset flag so a retry is possible if init genuinely fails.
    _googleSignInInitialized = false;
    debugPrint('GoogleSignIn initialize failed: $e');
    rethrow;
  }
}

/// Decodes the payload section of a JWT for debug logging only.
/// Never use this for security-sensitive validation.
Map<String, dynamic>? _decodeJwtPayload(String token) {
  try {
    final parts = token.split('.');
    if (parts.length != 3) return null;
    // Base64Url decode with padding
    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final decoded = utf8.decode(base64Url.decode(normalized));
    return jsonDecode(decoded) as Map<String, dynamic>;
  } catch (_) {
    return null;
  }
}

Future<GoogleSignInAccount?> signInWithGoogle() async {
  try {
    debugPrint('GoogleSignIn authenticate start');
    // Use signOut() (clears local keychain only) rather than disconnect()
    // which also REVOKES server-side tokens. On iOS, disconnect() followed
    // immediately by authenticate() can leave GIDSignIn in a transitional
    // state and return stale or revoked tokens.
    try {
      await _googleSignIn.signOut();
    } catch (_) {
      // Ignore sign-out errors; not fatal.
    }

    // authenticate() throws a GoogleSignInException if the user cancels.
    final GoogleSignInAccount? account = await _googleSignIn.authenticate(
      scopeHint: ['email', 'profile'],
    );
    debugPrint('GoogleSignIn authenticate success: email=${account?.email}');

    if (account != null) {
      // --- Debug: log idToken claims to verify audience and expiry ---
      final String? idToken = account.authentication.idToken;
      if (idToken != null) {
        final payload = _decodeJwtPayload(idToken);
        debugPrint('GoogleSignIn idToken audience (aud): ${payload?['aud']}');
        debugPrint('GoogleSignIn idToken issued_at  (iat): ${payload?['iat']}');
        debugPrint('GoogleSignIn idToken expires_at (exp): ${payload?['exp']}');
        debugPrint('GoogleSignIn idToken subject    (sub): ${payload?['sub']}');
      } else {
        debugPrint('GoogleSignIn WARNING: idToken is null after authenticate');
      }
    }

    return account;
  } on GoogleSignInException catch (e) {
    debugPrint(
      'GoogleSignIn exception: code=${e.code.name}, description=${e.description ?? 'none'}',
    );
    if (e.code == GoogleSignInExceptionCode.canceled) {
      return null;
    }
    rethrow;
  } catch (error) {
    rethrow;
  }
}

class AuthentificationRepositoryImpl implements AuthentificationRepository {
  final NetworkService networkService;

  AuthentificationRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<AuthentificationException, ResetPassword>> resetPassword(
      {required String email,
      required String code,
      required String newPassword}) async {
    try {
      final response = await networkService.post(
        AuthentificationConstants.resetPasswordPostUri,
        body: {
          'email': email,
          'code': code,
          'newPassword': newPassword,
        },
      );
      return Right(ResetPasswordModel.fromJson(
        response['data'] ?? response,
      ).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, ForgotPassword>> forgotPassword(
      String email) async {
    try {
      final response = await networkService.post(
        AuthentificationConstants.forgotPasswordPostUri,
        body: {
          'email': email,
        },
      );
      return Right(ForgotPasswordModel.fromJson(response['data']).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, bool>> resendOtp(
      String email) async {
    try {
      await networkService
          .get("${AuthentificationConstants.resendOtpPostUri}?email=$email");
      return const Right(true);
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, bool>> verifyEmail(
      String code) async {
    try {
      await networkService
          .get("${AuthentificationConstants.verifyEmailPostUri}/$code");
      return const Right(true);
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, Register>> register(
      {required String name,
      String? email,
      required String password,
      PhoneCommand? phone,
      required String dateOfBirth}) async {
    try {
      // print({
      //   'name': name,
      //   'email': email,
      //   'password': password,
      //   'phone': email != null
      //       ? null
      //       : {
      //           'code': phone?.code,
      //           'number': phone?.number,
      //         },
      //   'dateOfBirth': dateOfBirth,
      // });
      final response = await networkService.post(
        AuthentificationConstants.registerPostUri,
        body: {
          'name': name,
          'email': email,
          'password': password,
          'phone': null,
          'dateOfBirth': dateOfBirth,
        },
      );
      return Right(RegisterModel.fromJson(response['data']).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, Login>> login(
      {String? email,
      PhoneCommand? phone,
      required String password,
      bool? extend}) async {
    try {
      final response = await networkService.post(
        AuthentificationConstants.loginPostUri,
        body: {
          if (email != null) 'email': email,
          if (phone != null)
            'phone': {'code': phone.code, 'number': phone.number},
          'password': password,
          'extend': extend,
        },
      );
      return Right(LoginModel.fromJson(response["data"]).toEntity());
    } on BaseException catch (e) {
      print(e.message);
      String errorMessage = e.message;

      // Handle specific authentication errors
      if (e.statusCode == 401) {
        errorMessage = 'Invalid email or password';
      } else if (e.statusCode == 403) {
        errorMessage = 'Access denied. Please check your credentials.';
      } else if (e.statusCode == 404 && email != null) {
        errorMessage = 'User not found with email: $email';
      } else if (e.statusCode == 404 && phone != null) {
        errorMessage =
            'User not found with phone: ${phone.code}${phone.number}';
      } else if (errorMessage.isEmpty) {
        errorMessage = 'Login failed. Please try again.';
      } else if (e.statusCode == 500) {
        errorMessage = 'Invalid email or password';
      }

      return Left(AuthentificationException(errorMessage, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, Login>> googleLogin(
      {required String bearerId}) async {
    try {
      final response = await networkService
          .post(AuthentificationConstants.googleLoginPostUri, headers: {
        'Authorization': 'BearerId $bearerId',
        'Platform': Platform.isAndroid
            ? 'Android'
            : Platform.isIOS
                ? 'Ios'
                : 'Web',
      });
      final data = response['data'] as Map<String, dynamic>;
      return Right(LoginModel.fromJson(data).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, Login>> googleLogin2(
      {required String bearerId,
      required String email,
      required String name}) async {
    try {
      final response = await networkService
          .post(AuthentificationConstants.googleLoginPostUri2, headers: {
        'Authorization': 'BearerId# $bearerId',
        'Email': email,
        'Name': name,
      });
      return Right(LoginModel.fromJson(response['data']).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, Register>> googleRegister(
      {required String bearerId}) async {
    try {
      final response = await networkService
          .post(AuthentificationConstants.googleLoginPostUri, headers: {
        'Authorization': 'BearerId $bearerId',
        'Platform': Platform.isAndroid
            ? 'Android'
            : Platform.isIOS
                ? 'Ios'
                : 'Web',
      });
      return Right(RegisterModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, Register>> googleRegister2(
      {required String bearerId,
      required String email,
      required String name}) async {
    try {
      final response = await networkService
          .post(AuthentificationConstants.googleLoginPostUri2, headers: {
        'Authorization': 'BearerId# $bearerId',
        'Email': email,
        'Name': name,
      });
      return Right(RegisterModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, Login>> googleSignIn() async {
    try {
      await _initializeGoogleSignIn();
      final GoogleSignInAccount? account = await signInWithGoogle();

      if (account == null) {
        // User cancelled the sign-in flow
        return Left(AuthentificationException('Sign-in cancelled', 0,
            isCancelled: true));
      }

      final GoogleSignInAuthentication auth = account.authentication;
      final String? idToken = auth.idToken;

      // NOTE: On iOS, idToken.aud == iOS client ID
      //       On Android, idToken.aud == serverClientId (web client ID)
      // If the backend validates aud against only the web client ID it will
      // reject iOS tokens → "User session has expired". The backend must
      // accept the iOS client ID as a valid audience when Platform == Ios,
      // OR the validation must be updated to allow both client IDs.
      debugPrint(
          'GoogleSignIn sending idToken to backend (platform=${Platform.operatingSystem})');

      if (idToken == null) throw Exception('Missing Google ID Token');

      return await googleLogin(bearerId: idToken);
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    } catch (e) {
      return Left(AuthentificationException(e.toString(), 0));
    }
  }

  @override
  Future<Either<AuthentificationException, Register>> googleSignUp() async {
    try {
      await _initializeGoogleSignIn();
      final GoogleSignInAccount? account = await signInWithGoogle();
      if (account == null) {
        // User cancelled the sign-up flow
        return Left(AuthentificationException('Sign-up cancelled', 0,
            isCancelled: true));
      }

      final GoogleSignInAuthentication auth = account.authentication;
      final String? idToken = auth.idToken;

      // NOTE: Same iOS idToken audience caveat as googleSignIn() above.
      debugPrint(
          'GoogleSignUp sending idToken to backend (platform=${Platform.operatingSystem})');

      if (idToken == null) throw Exception('Missing Google ID Token');

      return await googleRegister2(
          bearerId: idToken,
          email: account.email,
          name: account.displayName ?? "");
    } on BaseException catch (e) {
      debugPrint('GoogleSignUp BaseException: $e');
      return Left(AuthentificationException(e.message, e.statusCode));
    } catch (e) {
      return Left(AuthentificationException(e.toString(), 0));
    }
  }

  // @override
  // Future<void> googleSignUp() async {
  //   final GoogleSignIn googleSignIn = GoogleSignIn(
  //     scopes: <String>['email'],
  //   );
  //   try {
  //     final GoogleSignInAccount? account = await googleSignIn.signIn();
  //     if (account == null) return; // user aborted

  //     final GoogleSignInAuthentication auth = await account.authentication;
  //     final String? idToken = auth.idToken;
  //     final String? accessToken = auth.accessToken;

  //     if (idToken == null) throw Exception('Missing Google ID Token');
  //     // Now send `idToken` to your backend
  //     // await sendTokenToServer(idToken);

  //     print(account);
  //     print(accessToken);
  //     print(idToken);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> googleLogout() async {
    _googleSignIn.disconnect();
  }

  // ── Apple Sign-In ────────────────────────────────────────────────────────

  @override
  Future<Either<AuthentificationException, Login>> appleLogin(
      {required String identityToken, String? fullName}) async {
    try {
      final response = await networkService
          .post(AuthentificationConstants.appleLoginPostUri, headers: {
        'Authorization': 'BearerId $identityToken',
        if (fullName != null && fullName.isNotEmpty) 'Name': fullName,
      });
      final data = response['data'] as Map<String, dynamic>;
      return Right(LoginModel.fromJson(data).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, Login>> appleSignIn() async {
    if (Platform.isAndroid) {
      return _appleSignInAndroid();
    } else {
      return _appleSignInIOS();
    }
  }

  // ── Apple Sign-In: iOS (native flow) ──────────────────────────────────

  Future<Either<AuthentificationException, Login>> _appleSignInIOS() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'com.jappcareautotech.jappcare.login',
          redirectUri: Uri.parse(
            'https://bpi.jappcare.com/api/v1/auth/oauth/apple/callback',
          ),
        ),
      );

      final String? identityToken = credential.identityToken;
      if (identityToken == null) {
        throw Exception('Apple Sign-In failed: No identity token received');
      }

      // Apple only provides the name on the FIRST sign-in
      String? fullName;
      if (credential.givenName != null || credential.familyName != null) {
        fullName =
            '${credential.givenName ?? ''} ${credential.familyName ?? ''}'
                .trim();
      }

      return await appleLogin(identityToken: identityToken, fullName: fullName);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled ||
          e.code == AuthorizationErrorCode.unknown) {
        return Left(AuthentificationException('Sign-in cancelled', 0,
            isCancelled: true));
      }
      return Left(AuthentificationException(e.message, 0));
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    } catch (e) {
      // Detect cancellation from generic exceptions (e.g. PlatformException)
      final msg = e.toString().toLowerCase();
      if (msg.contains('cancel') || msg.contains('user denied')) {
        return Left(AuthentificationException('Sign-in cancelled', 0,
            isCancelled: true));
      }
      return Left(AuthentificationException(e.toString(), 0));
    }
  }

  // ── Apple Sign-In: Android (web redirect flow) ────────────────────────
  //
  // 1. Opens Apple's authorization URL in the device's default browser.
  // 2. Apple POSTs id_token + code + user to backend callback:
  //    https://bpi.jappcare.com/api/v1/auth/oauth/apple/callback
  // 3. Backend verifies the token, creates/finds user, generates JWTs.
  // 4. Backend redirects (302) to deep link:
  //    jappcare://auth/apple/callback?accessToken=...&refreshToken=...
  // 5. Android's intent system delivers the deep link to the app.
  // 6. app_links receives the URI on its stream.
  // 7. We parse the tokens from query parameters.

  static const String _appleServiceId = 'com.jappcareautotech.jappcare.login';
  static const String _appleRedirectUri =
      'https://bpi.jappcare.com/api/v1/auth/oauth/apple/callback';

  Future<Either<AuthentificationException, Login>> _appleSignInAndroid() async {
    StreamSubscription<Uri>? linkSub;
    try {
      final appleAuthUrl = Uri.https('appleid.apple.com', '/auth/authorize', {
        'client_id': _appleServiceId,
        'redirect_uri': _appleRedirectUri,
        'response_type': 'code id_token',
        'response_mode': 'form_post',
        'scope': 'name email',
      });

      print('[AppleSignIn-Android] Opening Apple auth URL in browser...');

      // Completer that resolves when the deep link arrives
      final completer = Completer<Uri>();

      // Listen for deep links via native EventChannel (MainActivity.kt)
      linkSub = DeepLinkService.instance.linkStream.listen((uri) {
        print('[AppleSignIn-Android] Deep link received: $uri');
        if (uri.scheme == 'jappcare' &&
            uri.host == 'auth' &&
            uri.path.startsWith('/apple/callback') &&
            !completer.isCompleted) {
          completer.complete(uri);
        }
      });

      // Open Apple's auth page in the device's default browser
      final launched = await launchUrl(
        appleAuthUrl,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        throw Exception('Could not open Apple Sign-In page in browser');
      }

      // Wait for the backend to redirect back via jappcare:// deep link
      final callbackUri = await completer.future.timeout(
        const Duration(minutes: 5),
        onTimeout: () {
          throw TimeoutException('Apple Sign-In timed out');
        },
      );

      final result = _handleAppleCallback(callbackUri);

      result.fold(
        (error) => print('[AppleSignIn-Android] Error: ${error.message}'),
        (login) => print('[AppleSignIn-Android] Success: tokens received'),
      );

      return result;
    } on BaseException catch (e) {
      print('[AppleSignIn-Android] BaseException: ${e.message}');
      return Left(AuthentificationException(e.message, e.statusCode));
    } catch (e) {
      print('[AppleSignIn-Android] Exception: $e');
      if (e is TimeoutException) {
        return Left(AuthentificationException(
            'Apple Sign-In timed out. Please try again.', 0));
      }
      return Left(AuthentificationException(e.toString(), 0));
    } finally {
      await linkSub?.cancel();
    }
  }

  /// Parses tokens from the deep link callback URI.
  ///
  /// Success: jappcare://auth/apple/callback?accessToken=...&refreshToken=...&accessTokenExpiry=...
  /// Failure: jappcare://auth/apple/callback?error=...
  Either<AuthentificationException, Login> _handleAppleCallback(Uri uri) {
    // Check for error first
    final error = uri.queryParameters['error'];
    if (error != null) {
      return Left(AuthentificationException(error, 0));
    }

    final accessToken = uri.queryParameters['accessToken'];
    final refreshToken = uri.queryParameters['refreshToken'];

    if (accessToken == null || refreshToken == null) {
      return Left(AuthentificationException(
          'Missing tokens in Apple callback response', 0));
    }

    // Tokens received directly from backend via deep link — no extra API call needed
    return Right(Login.create(
      accessToken: accessToken,
      refreshToken: refreshToken,
    ));
  }

  @override
  Future<Either<AuthentificationException, Login>> appleSignUp() async {
    // Apple Sign-In uses the same flow for both login and signup.
    // The backend handles new-user creation automatically.
    return appleSignIn();
  }

  //Add methods here

  @override
  Future<Either<AuthentificationException, bool>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await networkService.post(
        AuthentificationConstants.changePasswordPostUri,
        body: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        },
      );
      return const Right(true);
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }
}
