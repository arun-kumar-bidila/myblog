part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class ProfileChangePassword extends ProfileEvent {
  final String currentPassword;
  final String newPassword;
  ProfileChangePassword({
    required this.currentPassword,
    required this.newPassword,
  });
}


final class ProfileFetchUserBlogs extends ProfileEvent{}
