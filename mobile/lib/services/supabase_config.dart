import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/config/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static Future<void> init({http.Client? httpClient}) async {
    await Supabase.initialize(
      url: ENV.BASE_URL,
      anonKey: ENV.PUBLIC_KEY,
      httpClient: httpClient,
      // localStorage: SecureLocalStorage(),
      debug: kDebugMode,
    );
  }

  SupabaseClient get client => Supabase.instance.client;
}
