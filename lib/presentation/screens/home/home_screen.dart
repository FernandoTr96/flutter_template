import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/presentation/providers/index.dart';

class HomeScreen extends ConsumerWidget {
  
  static String name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: FilledButton(onPressed: () async {
          await ref.read(authStateProvider.notifier).logout();
        }, child: const Text('Sign out')) 
      )
    );
  }
}