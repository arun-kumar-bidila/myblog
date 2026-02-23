import 'package:fpdart/fpdart.dart';
import 'package:myblog/common/entites/user.dart';
import 'package:myblog/common/usecase/usecase.dart';
import 'package:myblog/core/error/failure.dart';
import 'package:myblog/features/auth/domain/repository/auth_repository.dart';

class VerifyEmailOtp implements UseCase<User, VerifyEmailOtpParams> {
  final AuthRepository authRepository;

  VerifyEmailOtp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(VerifyEmailOtpParams params) async {
    return await authRepository.verifyEmailOtp(
      email: params.email,
      otp: params.otp,
    );
  }
}

class VerifyEmailOtpParams {
  final String email;
  final String otp;

  VerifyEmailOtpParams({required this.email, required this.otp});
}
