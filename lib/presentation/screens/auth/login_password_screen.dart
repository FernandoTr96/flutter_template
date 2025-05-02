import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/config/router/app_router.dart';
import 'package:flutter_template/presentation/providers/auth/login_providers.dart';

class LoginPasswordScreen extends ConsumerWidget {

  static String name = 'login_password_screen';

  const LoginPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final router = ref.watch(appRouter);
    final colors = Theme.of(context).colorScheme;
    final loginPasswordNotifier = ref.watch(loginPasswordProvider.notifier);
    final obscurePasswordNotifier = ref.watch(obscurePasswordProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: ()=> router.pop(), 
                    icon: const Icon(Icons.arrow_back_outlined)
                  )
                ]
              ),
              const Text('Ingresa tu contraseña de la aplicación', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                onChanged: loginPasswordNotifier.onChanged,
                style: TextStyle(fontSize: 30, color: colors.secondary, fontWeight: FontWeight.w600),
                obscureText: true,
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 30, color: Colors.grey.shade400, fontWeight: FontWeight.w600),
                  hintText: 'contraseña',
                  contentPadding: const EdgeInsets.all(8.0),
                  suffixIcon: IconButton(
                    onPressed: () => obscurePasswordNotifier.state = !obscurePasswordNotifier.state, 
                    icon: ref.watch(obscurePasswordProvider) ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)
                  )
                )
              )
            ]
          )
        )
      ),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: IconButton.filled(
          onPressed: ref.watch(loginPasswordProvider).isNotEmpty ? (){} : null,
          icon: const Icon(Icons.send, size: 28),
        )
      )
    );
  }
}