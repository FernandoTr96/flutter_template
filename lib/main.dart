import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/config/helpers/index.dart';
import 'package:flutter_template/config/router/app_router.dart';
import 'package:flutter_template/config/theme/app_theme.dart';

void main() async {
  await libInitializer();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {

  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final router = ref.watch(appRouter);
    
    // cambiar el color de iconos de barra de estado
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,    
        statusBarIconBrightness: Brightness.dark,   // Android
        statusBarBrightness: Brightness.dark,      // IOS
      ),
    );

    // configuraciones de la pp
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: AppTheme().lightThemeSchema
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
