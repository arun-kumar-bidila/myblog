import 'package:fpdart/fpdart.dart';
import 'package:myblog/common/usecase/usecase.dart';
import 'package:myblog/core/error/failure.dart';
import 'package:myblog/features/profile/domain/repository/profile_repository.dart';

class ChangePasswordUseCase implements UseCase<String, ChangePasswordParams> {
  final ProfileRepository profileRepository;
  ChangePasswordUseCase(this.profileRepository);
  @override
  Future<Either<Failure, String>> call(ChangePasswordParams params) async {
    return await profileRepository.changePassword(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
    );
  }
}

class ChangePasswordParams {
  final String currentPassword;
  final String newPassword;
  ChangePasswordParams({
    required this.currentPassword,
    required this.newPassword,
  });
}
