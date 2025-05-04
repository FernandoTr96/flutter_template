import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/config/enum/auth_enum.dart';
import 'package:flutter_template/presentation/providers/auth/auth_providers.dart';

final appRouterNotifierProvider = Provider((ref) {
  final authStateNotifier = ref.watch(authStateProvider.notifier);
  return AppRouterNotifier(authStateNotifier);
});

class AppRouterNotifier extends ChangeNotifier {

  final AuthStateNotifier _authStateNotifier;
  AuthEnum _authStatus = AuthEnum.unauthenticated;

  AppRouterNotifier(this._authStateNotifier){
    _authStateNotifier.addListener((state){
      _authStatus = state.authStatus;
    });
  }

  AuthEnum get authStatus => _authStatus;

  set setAuthStatus(AuthEnum status){
    _authStatus = status;
    notifyListeners();
  }

}