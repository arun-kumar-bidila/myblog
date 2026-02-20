import 'package:fpdart/fpdart.dart';
import 'package:myblog/core/error/failure.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, String>> changePassword({required String currentPassword,required String newPassword});
}
