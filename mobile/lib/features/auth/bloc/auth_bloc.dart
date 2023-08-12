import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/auth/repo/auth_repo.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/services/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInWithGoogleEvent>(_signInWithGoogle);
    on<SignOutEvent>(_signOut);
    on<GetCurrentUserEvent>(_getCurrentUser);
    on<IsSignedInEvent>(_isSignedIn);
  }

  final AuthRepository _authRepository = getIt<AuthRepositoryImpl>();
  final SupabaseConfig _supabaseConfig = getIt<SupabaseConfig>();

  Future<void> _signInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.signInWithGoogle(
        client: _supabaseConfig.client,
      );
      if (response.user != null) {
        emit(AuthSuccess(user: response.user));
      } else {
        emit(const AuthFailure(message: 'Sign in failed'));
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  FutureOr<void> _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.signOut(
        client: _supabaseConfig.client,
      );
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  FutureOr<void> _getCurrentUser(
    GetCurrentUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.getCurrentUser(
        client: _supabaseConfig.client,
      );
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  FutureOr<void> _isSignedIn(
    IsSignedInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.getCurrentUser(
        client: _supabaseConfig.client,
      );
      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(const AuthFailure(message: 'User is not signed in'));
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
