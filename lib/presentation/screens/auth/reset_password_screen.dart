import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {

  static String name = 'reset_password_screen';
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Center(
          child: Text('Reset password screen')
        )
      )
    );
  }
}