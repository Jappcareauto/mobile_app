import 'package:google_sign_in/google_sign_in.dart';

// Implementation of Google authentication service
class GoogleAuthService {
  // Private constructor to prevent external instantiation
  GoogleAuthService._privateConstructor();

  // Singleton instance
  static final GoogleAuthService _instance =
      GoogleAuthService._privateConstructor();

  // Public accessor for the singleton instance
  static GoogleAuthService get instance => _instance;

  // Internal GoogleSignIn instance (v7+ uses the global instance)
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  /// Initialize the configuration - MUST be called once (e.g., in main.dart)
  Future<void> initialize() async {
    // 1. You must call initialize() on the instance before anything else
    // You can pass clientId or serverClientId here if not using google-services.json
    await _googleSignIn.initialize(
        serverClientId:
            "303138649390-t63gmvdrrnuct9a6ka8rjfjdfop977s4.apps.googleusercontent.com"
        // "415070003598-pc9dsnpisbn9uvil4lpuh339bh6ran3p.apps.googleusercontent.com"
        ,
        clientId:
            "303138649390-t63gmvdrrnuct9a6ka8rjfjdfop977s4.apps.googleusercontent.com");

    // 2. The new way to listen to user changes
    _googleSignIn.authenticationEvents
        .listen((GoogleSignInAuthenticationEvent event) {
      if (event is GoogleSignInAuthenticationEventSignIn) {
        // Handle sign-in event
        print("User signed in: ${event.user.email}");
      } else if (event is GoogleSignInAuthenticationEventSignOut) {
        // Handle sign-out event
        print("User signed out");
      }
    });

    // 3. Optionally, Restore session silently
    await _googleSignIn.attemptLightweightAuthentication();
  }

  // Trigger Sign-In
  Future<GoogleSignInAccount?> signIn() async {
    try {
      return await _googleSignIn.authenticate(
        scopeHint: ['email', 'profile'],
      );
    } on GoogleSignInException catch (e) {
      print('Google Sign-In error: $e');
      print('Google Sign-In error: ${e.code.toString()}');
      // You can now check the error code for specific cases, like cancellation.
      if (e.code == GoogleSignInExceptionCode.canceled) {
        // User cancelled
        return null;
      }
      rethrow;
    } catch (error) {
      print("Sign-In Error: $error");
      rethrow;
    }
  }

  // Trigger Sign-Out
  Future<void> signOut() async => await _googleSignIn.signOut();
}
