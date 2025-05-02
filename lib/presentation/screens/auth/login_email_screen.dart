import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/config/router/app_router.dart';
import 'package:flutter_template/presentation/screens/index.dart';
import 'package:flutter_template/presentation/providers/auth/login_providers.dart';

class LoginEmailScreen extends ConsumerWidget {

  static String name = 'login_email_screen';

  const LoginEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final router = ref.watch(appRouter);
    final colors = Theme.of(context).colorScheme;
    final loginEmailNotifier = ref.watch(loginEmailProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ingresa tu correo corporativo para acceder', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                onChanged: loginEmailNotifier.onChanged,
                style: TextStyle(fontSize: 30, color: colors.secondary, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 30, color: Colors.grey.shade400, fontWeight: FontWeight.w600),
                  hintText: 'example@aclara.mx',
                  errorText: !ref.watch(isValidEmailProvider) ? 'No es un correo electronico valido' : null,
                  contentPadding: const EdgeInsets.all(8.0)
                )
              )
            ]
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: IconButton.filled(
          onPressed: ref.watch(isValidEmailProvider) ? ()=> router.pushNamed(LoginPasswordScreen.name) : null, 
          icon: const Icon(Icons.arrow_forward_outlined, size: 28),
        ),
      )
    );
  }
}