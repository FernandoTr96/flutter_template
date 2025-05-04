import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/domain/entities/auth.dart';
import 'package:flutter_template/config/enum/auth_enum.dart';
import 'package:flutter_template/presentation/providers/index.dart';

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
      authStatus: AuthEnum.unauthenticated
    )
  );
}

class AuthState {

  final Auth? auth;
  final AuthEnum authStatus;

  AuthState({required this.auth, required this.authStatus});

  AuthState copyWith({
    Auth? auth,
    AuthEnum? authStatus,
  }) {
    return AuthState(
      auth: auth ?? this.auth,
      authStatus: authStatus ?? this.authStatus,
    );
  }
}
