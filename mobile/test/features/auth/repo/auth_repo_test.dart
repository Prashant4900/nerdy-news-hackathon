import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/features/auth/repo/auth_repo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../mock/mock_supabase_config.dart';

class MockAuthRepositoryImpl extends Mock implements AuthRepositoryImpl {}

@GenerateMocks([http.Client])
void main() {
  group('AuthRepositoryImpl Unit Testing', () {
    final mockSupabaseConfig = MockSupabaseConfig();
    final mockAuthRepositoryImpl = MockAuthRepositoryImpl();

    test('signInWithGoogle', () async {
      final result = mockAuthRepositoryImpl.signInWithGoogle(
        client: mockSupabaseConfig.client,
      );

      when(result).thenAnswer((_) async => AuthResponse());

      final result0 = await mockAuthRepositoryImpl.signInWithGoogle(
        client: mockSupabaseConfig.client,
      );
      expect(result0, isA<AuthResponse>());
    });
  });
}
