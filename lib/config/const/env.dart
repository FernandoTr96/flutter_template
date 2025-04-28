import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String api = dotenv.env['API'] ?? 'api url key doest exist';
}