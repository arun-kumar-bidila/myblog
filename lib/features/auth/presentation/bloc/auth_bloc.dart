import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:myblog/common/cubits/app_user/app_user_cubit.dart';
import 'package:myblog/common/usecase/usecase.dart';
import 'package:myblog/common/entites/user.dart';
import 'package:myblog/features/auth/domain/usecases/get_user.dart';
import 'package:myblog/features/auth/domain/usecases/user_login.dart';
import 'package:myblog/features/auth/domain/usecases/user_logout.dart';
import 'package:myblog/features/auth/domain/usecases/user_signup.dart';
import 'package:myblog/features/auth/domain/usecases/verify_email_otp.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignUp;
  final UserLogin _userLogin;
  final GetUser _getUser;
  final AppUserCubit _appUserCubit;
  final UserLogout _userLogout;
  final VerifyEmailOtp _verifyEmailOtp;
  AuthBloc({
    required UserSignup userSignUp,
    required UserLogin userLogin,
    required GetUser getUser,
    required AppUserCubit appUserCubit,
    required UserLogout userLogout,
    required VerifyEmailOtp verifyEmailOtp,
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       _getUser = getUser,
       _appUserCubit = appUserCubit,
       _userLogout = userLogout,
       _verifyEmailOtp = verifyEmailOtp,

       super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);

    on<AuthLogin>(_onAuthLogin);
    on<IsUserLoggedIn>(_getUserData);
    on<AuthUserLogOut>(_onAuthUserLogOut);
    on<AuthVerifyEmailOtp>(_onVeriyEmailOtp);
  }

  void _onAuthUserLogOut(AuthUserLogOut event, Emitter<AuthState> emit) async {
    emit(AuthLogOutLoading());
    final res = await _userLogout(NoParams());

    res.fold((l) => emit(AuthLogOutFailure(l.message)), (r) {
      _appUserCubit.updateUser(null);
      emit(AuthLogOutSuccess(r));
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

    res.fold((l) => emit(AuthEmailOtpSentFailure(l.message)), (r) {
      // _appUserCubit.updateUser(user);
      emit(AuthEmailOtpSentSuccess(r));
    });
  }

  void _onVeriyEmailOtp(
    AuthVerifyEmailOtp event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _verifyEmailOtp(
      VerifyEmailOtpParams(email: event.email, otp: event.otp),
    );

    res.fold((l) => emit(AuthSignUpFailure(l.message)), (r) {
      _appUserCubit.updateUser(r);
      emit(AuthSignUpSuccess(r));
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
