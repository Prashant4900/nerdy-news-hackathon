import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:mobile/config/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  // Sign in with google
  Future<AuthResponse> signInWithGoogle({required SupabaseClient client});
  // Get the current user
  Future<User?> getCurrentUser({required SupabaseClient client});
  // Sign out the user
  Future<void> signOut({required SupabaseClient client});
}

class AuthRepositoryImpl extends AuthRepository {
  final appAuth = const FlutterAppAuth();

  /// Function to generate a random 16 character string.
  String _generateRandomString() {
    final random = Random.secure();
    return base64Url.encode(List<int>.generate(16, (_) => random.nextInt(256)));
  }

  @override
  Future<AuthResponse> signInWithGoogle({
    required SupabaseClient client,
  }) async {
    // Just a random string
    final rawNonce = _generateRandomString();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

    final clientId = Platform.isIOS ? ENV.IOS_CLIENT_ID : ENV.ANDROID_CLIENT_ID;

    const applicationId = 'com.example.mobile';

    /// Fixed value for google login
    const redirectUrl = '$applicationId:/google_auth';

    /// Fixed value for google login
    const discoveryUrl =
        'https://accounts.google.com/.well-known/openid-configuration';

    try {
      // authorize the user by opening the concent page
      final result = await appAuth.authorize(
        AuthorizationRequest(
          clientId,
          redirectUrl,
          discoveryUrl: discoveryUrl,
          nonce: hashedNonce,
          scopes: [
            'openid',
            'email',
          ],
        ),
      );

      if (result == null) {
        throw Exception('No result');
      }

      // Request the access and id token to google
      final tokenResult = await appAuth.token(
        TokenRequest(
          clientId,
          redirectUrl,
          authorizationCode: result.authorizationCode,
          discoveryUrl: discoveryUrl,
          codeVerifier: result.codeVerifier,
          nonce: result.nonce,
          scopes: [
            'openid',
            'email',
          ],
        ),
      );

      final idToken = tokenResult?.idToken;

      if (idToken == null) {
        throw Exception('No idToken');
      }

      final authResponse = await client.auth.signInWithIdToken(
        provider: Provider.google,
        idToken: idToken,
        nonce: rawNonce,
      );

      return authResponse;
    } catch (e) {
      throw Exception('Error signing in with google');
    }
  }

  @override
  Future<void> signOut({required SupabaseClient client}) async {
    try {
      await client.auth.signOut();
    } catch (e) {
      throw Exception('Error signing out');
    }
  }

  @override
  Future<User?> getCurrentUser({required SupabaseClient client}) async {
    try {
      final user = client.auth.currentUser;
      print(user);
      return user;
    } catch (e) {
      throw Exception('Error getting current user');
    }
  }
}
