import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myblog/common/usecase/usecase.dart';
import 'package:myblog/features/blog/domain/entitites/blog.dart';
import 'package:myblog/features/profile/domain/usecases/change_password.dart';
import 'package:myblog/features/profile/domain/usecases/fetch_user_blogs.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ChangePasswordUseCase _changePasswordUseCase;
  final FetchUserBlogs _fetchUserBlogs;
  ProfileBloc({
    required ChangePasswordUseCase changePasswordUseCase,
    required FetchUserBlogs fetchUserBlogs,
  }) : _changePasswordUseCase = changePasswordUseCase,
       _fetchUserBlogs = fetchUserBlogs,
       super(ProfileInitial()) {
    on<ProfileChangePassword>(_changePassword);
    on<ProfileFetchUserBlogs>(_fetchBlogs);
  }

  void _changePassword(
    ProfileChangePassword event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileChangePasswordLoading());
    final res = await _changePasswordUseCase(
      ChangePasswordParams(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      ),
    );

    return res.fold(
      (l) => emit(ProfileChangePasswordFailure(l.message)),
      (r) => emit(ProfileChangePasswordSuccess(r)),
    );
  }

  void _fetchBlogs(
    ProfileFetchUserBlogs event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileFetchUserBlogsLoading());
    final res = await _fetchUserBlogs(NoParams());
    res.fold(
      (l) => emit(ProfileFetchUserBlogsFailure(l.message)),
      (blogs) => emit(ProfileFetchUserBlogsSuccess(blogs)),
    );
  }
}
