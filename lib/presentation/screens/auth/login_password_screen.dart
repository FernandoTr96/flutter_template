import 'package:flutter/material.dart';

class LoginPasswordScreen extends StatelessWidget {

  static String name = 'login_password_screen';

  const LoginPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ingresa tu contraseña de la aplicación', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                style: TextStyle(fontSize: 30, color: colors.secondary, fontWeight: FontWeight.w600),
                obscureText: true,
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 30, color: Colors.grey.shade400, fontWeight: FontWeight.w600),
                  hintText: 'contraseña',
                  contentPadding: const EdgeInsets.all(8.0),
                  suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.visibility_off))
                )
              )
            ]
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: IconButton(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
            backgroundColor: WidgetStatePropertyAll(colors.primary),
            foregroundColor: WidgetStatePropertyAll(colors.onPrimary),
          ),
          onPressed:(){}, 
          icon: const Icon(Icons.send, size: 28),
        ),
      )
    );
  }
}