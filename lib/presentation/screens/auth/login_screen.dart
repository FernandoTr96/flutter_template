import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  
  static String name = 'login_screen';

  const LoginScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Center(
          child: Text('Login Screen')
        )
      )
    );
  }
}