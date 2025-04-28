import 'package:flutter_template/config/plugins/index.dart';

Future<void> mainLoader() async {
  // cargar dotenv en main
  await DotenvPlugin.load('.env');
}