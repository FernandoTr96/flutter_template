import 'package:go_router/go_router.dart';
import 'package:flutter_template/presentation/screens/index.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen()
    ),
    GoRoute(
      path: '/login/:view',
      builder: (context, state) => const LoginScreen()
    ),
    GoRoute(
      path: '/reset-password',
      builder: (context, state) => const ResetPasswordScreen()
    )
  ]
);