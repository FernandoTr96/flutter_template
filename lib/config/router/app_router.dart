import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/config/enum/auth_enum.dart';
import 'package:flutter_template/presentation/screens/index.dart';
import 'package:flutter_template/presentation/providers/auth/login_providers.dart';
import 'package:flutter_template/config/router/app_router_notifier.dart';

final appRouter = Provider((ref){

  final appRouterNotifier = ref.watch(appRouterNotifierProvider);
  final localTokenFuture = ref.watch(hasLocalTokenProvider.future);

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
      final authStatus = appRouterNotifier.authStatus;
      final hasTokenInStorage = await localTokenFuture;
      
      if(goingTo == '/auth-checking' && authStatus == AuthEnum.checking) return null;
      
      if(authStatus == AuthEnum.authenticated){
        if(goingTo == '/login' || goingTo == '/login-email' || goingTo == '/login-password') return '/';
      }

      if(authStatus == AuthEnum.unauthenticated){
        if(goingTo == '/auth-checking' && !hasTokenInStorage) return '/login-email';
        if(goingTo == '/auth-checking' && hasTokenInStorage) return '/login';
      }

      return null;

    }
  );
});