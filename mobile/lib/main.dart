import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mobile/app/app.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/services/cache_helper.dart';
import 'package:mobile/services/supabase_config.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await setup();
  await ENV.init();
  await CacheHelper.init();
  await SupabaseConfig.init();
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}
