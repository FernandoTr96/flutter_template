import 'package:flutter_riverpod/flutter_riverpod.dart';

// current option selected in the menu
final menuIndexProvider = StateProvider<int>((ref)=> 0);
// current langague in the app
final languageProvider = StateProvider<String>((ref)=> 'es');
// toggle for darkmode and light mode
final isDarkModeProvider = StateProvider<bool>((ref)=> false);
// loading state for whole app 
final appLoadingProvider = StateProvider<bool>((ref) => false);
