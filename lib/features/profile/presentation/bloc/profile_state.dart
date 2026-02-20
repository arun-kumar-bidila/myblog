part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileChangePasswordSuccess extends ProfileState {
  final String message;
  ProfileChangePasswordSuccess(this.message);
}

final class ProfileChangePasswordFailure extends ProfileState {
    final String message;
  ProfileChangePasswordFailure(this.message);
}

final class ProfileChangePasswordLoading extends ProfileState{}