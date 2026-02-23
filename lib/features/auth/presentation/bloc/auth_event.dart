part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignUp({required this.name, required this.email, required this.password});
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  AuthLogin({required this.email, required this.password});
}

final class IsUserLoggedIn extends AuthEvent {}

final class AuthUserLogOut extends AuthEvent {}

final class AuthVerifyEmailOtp extends AuthEvent {
  final String email;
  final String otp;
  AuthVerifyEmailOtp({required this.email, required this.otp});
}
