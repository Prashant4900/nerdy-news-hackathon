// ignore_for_file: non_constant_identifier_names, cast_nullable_to_non_nullable

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ENV {
  static Future<void> init() async {
    await dotenv.load(fileName: 'assets/env/development.env');
  }

  static String BASE_URL = dotenv.env['BASE_URL'] as String;
  static String PUBLIC_KEY = dotenv.env['PUBLIC_KEY'] as String;
  static String SECRET_KEY = dotenv.env['SECRET_KEY'] as String;
  static String ANDROID_CLIENT_ID = dotenv.env['ANDROID_CLIENT_ID'] as String;
  static String IOS_CLIENT_ID = dotenv.env['IOS_CLIENT_ID'] as String;

  // Table name
  static String NEWS_TABLE = dotenv.env['NEWS_TABLE'] as String;
  static String PUBLISHER_TABLE = dotenv.env['PUBLISHER_TABLE'] as String;
}
