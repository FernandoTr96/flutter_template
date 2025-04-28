import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotenvPlugin {

  static Future<void> load(String fileName) async {
    await dotenv.load(fileName: fileName);
  }
  
}