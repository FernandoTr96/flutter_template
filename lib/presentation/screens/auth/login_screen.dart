import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/config/router/app_router.dart';
import 'package:flutter_template/presentation/providers/index.dart';
import 'package:flutter_template/presentation/screens/index.dart';

class LoginScreen extends StatelessWidget {
  
  static String name = 'login_screen';

  const LoginScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Column(
        children: [
          _Brand(),
          _AuthButtons()
        ]
      )
    );
  }
}

class _Brand extends ConsumerWidget {
  
  const _Brand();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final authProvider = ref.watch(authStateProvider);

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/img/logo-eco.png',
                      width: 45,
                      height: 45,
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        Text('APP', style: TextStyle(fontSize: 23, color: colors.secondary, fontWeight: FontWeight.w500)),
                        const SizedBox(width: 10),
                        const Text('BOILERPLATE', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
                      ]
                    )
                  ]
                ),
                const SizedBox(height: 20),
                Text('Aplicación movil empresarial de uso exclusivo para empleados autorizados de la empresa.', style: textStyles.titleSmall, textAlign: TextAlign.justify),
                const SizedBox(height: 5),
                Text(authProvider.error, style: TextStyle(color: colors.error), textAlign: TextAlign.start)
              ]
            )
          )
        ]
      )
    );
  }
}

class _AuthButtons extends ConsumerWidget {
  
  const _AuthButtons();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final router = ref.watch(appRouter);

    return SizedBox(
      width: double.infinity,          
      height: size.height * 0.5,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.85,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await ref.read(authStateProvider.notifier).signInWithBiometrics();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: colors.onPrimary,
                  padding: const EdgeInsets.all(13.0)
                ),
                icon: const Icon(Icons.login),
                label: const Text('Ingresar con rostro o huella')
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.85,
              child: TextButton.icon(
                onPressed: () async {
                  final hasEmailInStorage = await ref.read(hasLocalEmailProvider.future);
                  hasEmailInStorage ? 
                  router.pushNamed(LoginPasswordScreen.name) :
                  router.pushNamed(LoginEmailScreen.name); 
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: colors.secondary,
                  padding: const EdgeInsets.all(13.0)
                ),
                icon: ref.watch(hasLocalEmailProvider).isLoading ? 
                CircularProgressIndicator(strokeWidth: 2, color: colors.onSecondary) : 
                const Icon(Icons.lock),
                label: const Text('Ingresar con contraseña')
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'company s.a de c.v', 
              style: TextStyle(
                color: colors.onSurface, 
                fontSize: 12, 
                fontStyle: FontStyle.italic
              )
            ),
            const SizedBox(height: 60),
          ]
        )
      )
    );
  }
}

