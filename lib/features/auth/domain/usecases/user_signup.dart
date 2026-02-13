import 'package:fpdart/fpdart.dart';
import 'package:myblog/core/error/failure.dart';
import 'package:myblog/core/usecase/usecase.dart';
import 'package:myblog/core/entites/user.dart';
import 'package:myblog/features/auth/domain/repository/auth_repository.dart';

class UserSignup implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignup(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;
  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
