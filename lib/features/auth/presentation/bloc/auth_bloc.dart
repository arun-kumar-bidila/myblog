import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:myblog/core/cubits/app_user/app_user_cubit.dart';
import 'package:myblog/core/usecase/usecase.dart';
import 'package:myblog/core/entites/user.dart';
import 'package:myblog/features/auth/domain/usecases/get_user.dart';
import 'package:myblog/features/auth/domain/usecases/user_login.dart';
import 'package:myblog/features/auth/domain/usecases/user_logout.dart';
import 'package:myblog/features/auth/domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignUp;
  final UserLogin _userLogin;
  final GetUser _getUser;
  final AppUserCubit _appUserCubit;
  final UserLogout _userLogout;
  AuthBloc({
    required UserSignup userSignUp,
    required UserLogin userLogin,
    required GetUser getUser,
    required AppUserCubit appUserCubit,
    required UserLogout userLogout,
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       _getUser = getUser,
       _appUserCubit = appUserCubit,
       _userLogout = userLogout,

       super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);

    on<AuthLogin>(_onAuthLogin);
    on<IsUserLoggedIn>(_getUserData);
    on<AuthUserLogOut>(_onAuthUserLogOut);
  }

  void _onAuthUserLogOut(AuthUserLogOut event, Emitter<AuthState> emit) async {
    emit(AuthLogOutLoading());
    final res = await _userLogout(NoParams());

    res.fold((l) => emit(AuthLogOutFailure(l.message)), (r) {
      _appUserCubit.updateUser(null);
      emit(AuthLogOutSuccess());
    });
  }

  void _getUserData(IsUserLoggedIn event, Emitter<AuthState> emit) async {
    // emit(AuthLoading());

    final res = await _getUser(NoParams());

    res.fold(
      (l) {
        _appUserCubit.updateUser(null);
        // emit(AuthUserFetchFailure());
      },
      (user) {
        _appUserCubit.updateUser(user);
        // emit(AuthUserFetchSuccess(user));
      },
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    res.fold((l) => emit(AuthSignUpFailure(l.message)), (user) {
      _appUserCubit.updateUser(user);
      emit(AuthSignUpSuccess(user));
    });
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
      UserLoginParams(email: event.email, password: event.password),
    );

    res.fold((failure) => emit(AuthLoginFailure(failure.message)), (user) {
      _appUserCubit.updateUser(user);
      emit(AuthLoginSuccess(user));
    });
  }
}
