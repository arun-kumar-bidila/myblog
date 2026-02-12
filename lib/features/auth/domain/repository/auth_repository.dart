import 'package:fpdart/fpdart.dart';
import 'package:myblog/core/error/failure.dart';
import 'package:myblog/features/auth/domain/entites/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
