import 'package:fpdart/fpdart.dart';
import 'package:myblog/core/error/failure.dart';
import 'package:myblog/common/usecase/usecase.dart';
import 'package:myblog/common/entites/user.dart';
import 'package:myblog/features/auth/domain/repository/auth_repository.dart';

class GetUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  GetUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
     return await authRepository.getUserData();
  }
}
