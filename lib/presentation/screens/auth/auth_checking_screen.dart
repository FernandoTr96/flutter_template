import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/presentation/providers/auth/auth_provider.dart';

class AuthCheckingScreen extends ConsumerStatefulWidget {
  
  static String name = 'checking_screen';
  const AuthCheckingScreen({super.key});

  @override
  AuthCheckingScreenState createState() => AuthCheckingScreenState();
}

class AuthCheckingScreenState extends ConsumerState<AuthCheckingScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 100), () async {
      await ref.read(authStateProvider.notifier).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2, 
          color: colors.primary
        )
      )
    );
  }
}
