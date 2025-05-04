import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/domain/entities/auth.dart';
import 'package:flutter_template/config/enum/auth_enum.dart';
import 'package:flutter_template/presentation/providers/index.dart';
import 'package:flutter_template/infraestructure/errors/auth_errors.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier,AuthState>((ref) {
  
  final signInCallback = ref.watch(authRepositoryProvider).login;
  final logoutCallback = ref.watch(authRepositoryProvider).logout;
  final refreshCallback =  ref.watch(authRepositoryProvider).refresh;
  
  return AuthStateNotifier(
    signInCallback: signInCallback,
    logoutCallback: logoutCallback,
    refreshCallback: refreshCallback
  );

});

typedef SignInCallback = Future<Auth> Function({required String email, required String password});
typedef LogoutCallback = Future<void> Function();
typedef RefreshCallback = Future<Auth> Function();

class AuthStateNotifier extends StateNotifier<AuthState> {

  final SignInCallback signInCallback;
  final LogoutCallback logoutCallback;
  final RefreshCallback refreshCallback;

  AuthStateNotifier({
    required this.signInCallback, 
    required this.logoutCallback, 
    required this.refreshCallback
  }): super(
    AuthState(
      auth: null, 
      error: '',
      authStatus: AuthEnum.unauthenticated
    )
  );

  signIn({required String email, required String password}) async {
    try {
      final auth = await signInCallback(email: email, password: password);
      state = state.copyWith(auth: auth, authStatus: AuthEnum.authenticated);
    } on WrongCredentials {
      handleError(error: 'Correo o contraseña incorrecta');      
    } on TimeoutException {
      handleError(error: 'Intente mas tarde, el servidor ha tardado en responder');
    } catch(e){
      handleError(error: 'Error desconocido');
    }
  }

  refresh() async {
    try {
      final auth = await refreshCallback();
      state = state.copyWith(auth: auth, authStatus: AuthEnum.authenticated);    
    } on InvalidToken {
      handleError(error: 'El token de acceso ya no es valido');
    }
  }

  logout() async {
    await logoutCallback();
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
