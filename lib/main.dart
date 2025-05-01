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

class MainApp extends StatelessWidget {

  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    
    // cambiar el color de iconos de barra de estado
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,    
        statusBarIconBrightness: Brightness.dark,   // Android
        statusBarBrightness: Brightness.dark,      // IOS
      ),
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: AppTheme().lightThemeSchema),
      routerConfig: router
    );
  }
}
