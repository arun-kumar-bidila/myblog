
import 'package:fpdart/fpdart.dart';
import 'package:myblog/core/error/failure.dart';
import 'package:myblog/common/usecase/usecase.dart';
import 'package:myblog/features/auth/domain/repository/auth_repository.dart';

class UserLogout implements UseCase<String, NoParams> {
  final AuthRepository authRepository;
  UserLogout(this.authRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
   return await authRepository.userLogOut();
  }
}
