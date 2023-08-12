import 'package:http/http.dart' as http;
import 'package:mobile/services/supabase_config.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'mock_supabase_config.mocks.dart';

@GenerateMocks([http.Client])
class MockSupabaseConfig extends Mock implements SupabaseConfig {
  @override
  SupabaseClient get client => SupabaseClient(
        'supabaseUrl',
        'supabaseKey',
        httpClient: MockClient(),
      );
}
