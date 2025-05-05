import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/config/plugins/index.dart';
import 'package:flutter_template/domain/entities/auth.dart';
import 'package:flutter_template/config/enum/auth_enum.dart';
import 'package:flutter_template/config/const/variables.dart';
import 'package:flutter_template/infraestructure/errors/custom_error.dart';
import 'package:flutter_template/presentation/providers/index.dart';
import 'package:flutter_template/infraestructure/repositories/auth_repository_impl.dart';
import 'package:flutter_template/infraestructure/errors/auth_errors.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier,AuthState>((ref) {
  
  final storage = StoragePlugin();
  final authRepository = ref.watch(authRepositoryProvider);
  
  return AuthStateNotifier(
    authRepository: authRepository,
    storage: storage
  );

});

class AuthStateNotifier extends StateNotifier<AuthState> {

  final StoragePlugin storage;
  final AuthRepositoryImpl authRepository;

  AuthStateNotifier({
    required this.authRepository,
    required this.storage
  }): 
  super(
    AuthState(
      auth: null, 
      error: '',
      authStatus: AuthEnum.unauthenticated
    )
  );

  signIn({required String email, required String password}) async {
    try {
      
      state = state.copyWith(authStatus: AuthEnum.checking, error: '');
      final storedEmail = await storage.read(Variables.emailKey);
      final String? effectiveEmail = email.isNotEmpty ? email : storedEmail;

      if (effectiveEmail == null || effectiveEmail.isEmpty) {
        state = state.copyWith(error: 'No se encontró un email válido para iniciar sesión.');
        return;
      }

      final auth = await authRepository.login(email: effectiveEmail, password: password);
      await storage.write(Variables.tokenKey, auth.token);
      await storage.write(Variables.emailKey, auth.email);
      await storage.write(Variables.passwordKey, password);
      state = state.copyWith(auth: auth, authStatus: AuthEnum.authenticated);

    } on WrongCredentials {
      handleError(error: 'Correo o contraseña incorrecta');      
    } on TimeoutException {
      handleError(error: 'Intente mas tarde, el servidor ha tardado en responder');
    } catch(e){
      handleError(error: (e as CustomError).message);
    }
  }

  refresh() async {
    try {
      state = state.copyWith(authStatus: AuthEnum.checking);
      final auth = await authRepository.refresh();
      await storage.write(Variables.tokenKey, auth.token);
      await storage.write(Variables.emailKey, auth.email);
      state = state.copyWith(auth: auth, authStatus: AuthEnum.authenticated);    
    } on InvalidToken {
      handleError(error: 'El token de acceso no es valido');
    } on NoTokenInRequest {
      handleError(error: 'No hay un token que validar');
    }catch(e){
      handleError(error: (e as CustomError).message);
    }
  }

  signInWithBiometrics() async {
    final storage = StoragePlugin();
    final (isAuthenticated, message) = await BiometricPlugin.authenticate();
    if (isAuthenticated) {
      final String? email = await storage.read(Variables.emailKey);
      final String? password = await storage.read(Variables.passwordKey);
      signIn(email: email ?? '', password: password ?? '');
    }
    else{
      handleError(error: message);
    }
  }

  logout() async {
    await authRepository.logout();
    handleError(error: '');
  }

  handleError({required String error}){
    state = state.copyWith(
      auth: null,
      error: error, 
      authStatus: AuthEnum.unauthenticated
    );
  }
}

class AuthState {

  final Auth? auth;
  final AuthEnum authStatus;
  final String error;

  AuthState({
    required this.auth, 
    required this.authStatus,
    required this.error
  });

  AuthState copyWith({
    Auth? auth,
    AuthEnum? authStatus,
    String? error
  }) {
    return AuthState(
      auth: auth ?? this.auth,
      authStatus: authStatus ?? this.authStatus, 
      error: error ?? this.error
    );
  }
}
