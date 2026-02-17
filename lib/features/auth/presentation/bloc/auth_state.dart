part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
}

final class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

final class AuthUserFetchFailure extends AuthState {}

final class AuthLogOutSuccess extends AuthState {}

final class AuthLogOutFailure extends AuthState {
  final String message;
  AuthLogOutFailure(this.message);
}
