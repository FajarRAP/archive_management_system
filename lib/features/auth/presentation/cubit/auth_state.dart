part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class ProfileState extends AuthState {}
class LogoutState extends AuthState{}

class LoginLoading extends AuthState {}

class LoginLoaded extends AuthState {}

class LoginError extends AuthState {
  final String message;

  LoginError(this.message);
}
class LogoutLoading extends LogoutState {}

class LogoutLoaded extends LogoutState {
  final String message;

  LogoutLoaded(this.message);
}

class LogoutError extends LogoutState {
  final String message;

  LogoutError(this.message);
}

class ProfileLoading extends ProfileState {}
class ProfileLoaded extends ProfileState {
  final ProfileEntity user;

  ProfileLoaded(this.user);
}
class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
