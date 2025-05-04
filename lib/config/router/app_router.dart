import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/presentation/screens/index.dart';

final appRouter = Provider((ref)=> GoRouter(
  initialLocation: '/auth-checking',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen()
    ),
    GoRoute(
      path: '/login',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen()
    ),
    GoRoute(
      path: '/login-email',
      name: LoginEmailScreen.name,
      builder: (context, state) => const LoginEmailScreen()
    ),
    GoRoute(
      path: '/login-password',
      name: LoginPasswordScreen.name,
      builder: (context, state) => const LoginPasswordScreen()
    ),
    GoRoute(
      path: '/auth-checking',
      name: AuthCheckingScreen.name,
      builder: (context, state) => const AuthCheckingScreen()
    )
  ]
));