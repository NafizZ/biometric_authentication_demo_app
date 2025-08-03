import 'dart:developer';

import 'package:local_auth/local_auth.dart';
import '../model/auth_result.dart';

class AuthController {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<AuthResult> authenticate() async {
    try {
      final isSupported = await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

      if (!isSupported) {
        return AuthResult(success: false, message: 'Biometric authentication is not available');
      }

      final didAuthenticate = await _auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(biometricOnly: true),
      );

      return AuthResult(
        success: didAuthenticate,
        message: didAuthenticate ? 'Authentication successful' : 'Authentication failed',
      );
    } catch (e) {
      log('Authentication error: $e');
      return AuthResult(success: false, message: 'Error: $e');
    }
  }
}
