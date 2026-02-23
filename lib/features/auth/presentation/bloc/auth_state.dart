part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoginSuccess extends AuthState {
  final User user;
  AuthLoginSuccess(this.user);
}

final class AuthLoginFailure extends AuthState {
  final String message;

  AuthLoginFailure(this.message);
}

final class AuthSignUpSuccess extends AuthState {
  final User user;
  AuthSignUpSuccess(this.user);
}

final class AuthSignUpFailure extends AuthState {
  final String message;

  AuthSignUpFailure(this.message);
}

final class AuthEmailOtpSentSuccess extends AuthState {
  final String message;
  AuthEmailOtpSentSuccess(this.message);
}

final class AuthEmailOtpSentFailure extends AuthState {
  final String message;
  AuthEmailOtpSentFailure(this.message);
}

final class AuthUserFetchSuccess extends AuthState {
  final User user;
  AuthUserFetchSuccess(this.user);
}

final class AuthUserFetchFailure extends AuthState {}

final class AuthLogOutSuccess extends AuthState {
  final String message;
  AuthLogOutSuccess(this.message);
}

final class AuthLogOutLoading extends AuthState {}

final class AuthLogOutFailure extends AuthState {
  final String message;
  AuthLogOutFailure(this.message);
}
