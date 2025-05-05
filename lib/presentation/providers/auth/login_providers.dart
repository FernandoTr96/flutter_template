import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/config/const/index.dart';
import 'package:flutter_template/config/plugins/index.dart';

final storage = StoragePlugin();

final hasLocalTokenProvider = FutureProvider<bool>((ref) async {
  final token = await storage.read(Variables.tokenKey);
  return token != null && token.isNotEmpty;
});

final hasBeenLogedProvider = FutureProvider<bool>((ref) async {
  final email = await storage.read(Variables.emailKey);
  final password = await storage.read(Variables.passwordKey);
  return email != null && password != null;
});

final hasLocalEmailProvider = FutureProvider<bool>((ref) async {
  final storage = StoragePlugin();
  final email = await storage.read(Variables.emailKey);
  return email != null && email.isNotEmpty;
});

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

