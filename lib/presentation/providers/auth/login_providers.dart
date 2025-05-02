import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginErrorProvider = StateProvider<bool>((ref) => false);

final loginPasswordProvider = StateNotifierProvider<LoginFieldNotifier,String>((ref) {
  return LoginFieldNotifier();
});

final loginEmailProvider = StateNotifierProvider<LoginFieldNotifier,String>((ref) {
  return LoginFieldNotifier();
});

class LoginFieldNotifier extends StateNotifier<String>{
  LoginFieldNotifier(): super('');
  onChange(String value) => state = value;
  isValid() => state.isNotEmpty;
}