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

final class ProfileChangePasswordLoading extends ProfileState {}

final class ProfileFetchUserBlogsLoading extends ProfileState {}

final class ProfileFetchUserBlogsFailure extends ProfileState {
  final String message;
  ProfileFetchUserBlogsFailure(this.message);
}

final class ProfileFetchUserBlogsSuccess extends ProfileState {
  final List<Blog> blogs;
  ProfileFetchUserBlogsSuccess(this.blogs);

}
