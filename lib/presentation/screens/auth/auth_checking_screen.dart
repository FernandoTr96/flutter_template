import 'package:flutter/material.dart';

class AuthCheckingScreen extends StatelessWidget {

  static String name = 'checking_screen';
  const AuthCheckingScreen({super.key});

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



    