import 'package:fpdart/fpdart.dart';
import 'package:myblog/core/error/exceptions.dart';
import 'package:myblog/core/error/failure.dart';
import 'package:myblog/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:myblog/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource profileRemoteDatasource;
  ProfileRepositoryImpl(this.profileRemoteDatasource);
  @override
  Future<Either<Failure, String>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final res = await profileRemoteDatasource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
