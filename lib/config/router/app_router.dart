import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/config/enum/auth_enum.dart';
import 'package:flutter_template/presentation/screens/index.dart';
import 'package:flutter_template/config/router/app_router_notifier.dart';
import 'package:flutter_template/presentation/providers/auth/login_providers.dart';

final appRouter = Provider((ref){

  final appRouterNotifier = ref.watch(appRouterNotifierProvider);
  final hasBeenLogedFuture = ref.watch(hasBeenLogedProvider.future);

  return GoRouter(
    initialLocation: '/auth-checking',
    refreshListenable: appRouterNotifier,
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
    ],
    redirect: (context, state) async {

      final goingTo = state.matchedLocation; 
      final hasBeenLoged = await hasBeenLogedFuture;
      final authStatus = appRouterNotifier.authStatus;

      if(authStatus == AuthEnum.authenticated){
        if(goingTo == '/login' || goingTo == '/login-email' || goingTo == '/login-password' || goingTo == '/auth-checking') return '/';
      }

      if(authStatus == AuthEnum.unauthenticated){
        if(goingTo == '/login' || goingTo == '/login-email' || goingTo == '/login-password') return null;
        return hasBeenLoged ? '/login' : '/login-email';
      }

      return null;

    }
  );
});
