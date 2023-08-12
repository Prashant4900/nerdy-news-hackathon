part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  @override
  String toString() {
    return 'AuthInitial{}';
  }
}

class AuthLoading extends AuthState {
  @override
  String toString() {
    return 'AuthLoading{}';
  }
}

class AuthSuccess extends AuthState {
  const AuthSuccess({required this.user});
  final User? user;

  @override
  List<Object> get props => [user!];

  @override
  String toString() {
    return 'AuthSuccess{Email: ${user!.email}, Id: ${user!.id}, Role: ${user!.role}}';
  }
}

class AuthFailure extends AuthState {
  const AuthFailure({required this.message});
  final String message;

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return 'AuthFailure{message: $message}';
  }
}
