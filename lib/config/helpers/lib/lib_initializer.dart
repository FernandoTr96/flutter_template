import 'package:flutter_template/config/plugins/index.dart';

Future<void> libInitializer() async {
  // load dotenv library
  await DotenvPlugin.load('.env');
}