import 'package:flutter_riverpod/flutter_riverpod.dart';

final obscurePasswordProvider = StateProvider<bool>((ref) => true);

final loginEmailProvider = StateNotifierProvider<LoginFieldNotifier,String>((ref) {
  return LoginFieldNotifier();
});

final isValidEmailProvider = Provider<bool>((ref) {
  final email = ref.watch(loginEmailProvider);
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
});

final loginPasswordProvider = StateNotifierProvider<LoginFieldNotifier,String>((ref) {
  return LoginFieldNotifier();
});

class LoginFieldNotifier extends StateNotifier<String> {
  LoginFieldNotifier() : super('');
  void onChanged(String value) => state = value;
}
