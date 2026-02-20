import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myblog/features/profile/domain/usecases/change_password.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ChangePasswordUseCase _changePasswordUseCase;
  ProfileBloc({required ChangePasswordUseCase changePasswordUseCase})
    : _changePasswordUseCase = changePasswordUseCase,
      super(ProfileInitial()) {
    on<ProfileChangePassword>(_changePassword);
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
}
