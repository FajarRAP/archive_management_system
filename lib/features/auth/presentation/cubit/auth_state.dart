part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginLoaded extends AuthState {}

class LoginError extends AuthState {
  final String message;

  LoginError(this.message);
}
class LogoutLoading extends AuthState {}

class LogoutLoaded extends AuthState {
  final String message;

  LogoutLoaded(this.message);
}

class LogoutError extends AuthState {
  final String message;

  LogoutError(this.message);
}
