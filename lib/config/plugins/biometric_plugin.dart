import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class BiometricPlugin {
  static final LocalAuthentication auth = LocalAuthentication();
  static const biometricTypes = BiometricType.values;

  static Future<bool> isDeviceSupported() async {
    return await auth.isDeviceSupported();
  }

  static Future<(bool, String)> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Unlock',
          options: const AuthenticationOptions(useErrorDialogs: false));

      return (didAuthenticate, '');
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        return (
          false,
          "No se ha configurado ningún método biométrico en el dispositivo."
        );
      }
      if (e.code == auth_error.lockedOut) {
        return (
          false,
          "Demasiados intentos fallidos. Intenta nuevamente más tarde."
        );
      }
      if (e.code == auth_error.notAvailable) {
        return (
          false,
          "Tu dispositivo no cuenta con autenticación biométrica disponible. Usa tus credenciales para acceder."
        );
      }
      if (e.code == auth_error.passcodeNotSet) {
        return (
          false,
          "No se ha configurado un PIN o patrón de seguridad en el dispositivo."
        );
      }
      if (e.code == auth_error.permanentlyLockedOut) {
        return (
          false,
          "El sensor biométrico ha sido bloqueado permanentemente por múltiples intentos fallidos."
        );
      }
      return (false, "Error: $e");
    }
  }
}
