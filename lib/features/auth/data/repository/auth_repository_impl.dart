import 'package:fpdart/fpdart.dart';
import 'package:myblog/core/error/exceptions.dart';
import 'package:myblog/core/error/failure.dart';
import 'package:myblog/core/network/connection_checker.dart';
import 'package:myblog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:myblog/common/entites/user.dart';
import 'package:myblog/features/auth/data/models/user_model.dart';
import 'package:myblog/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);
  @override
  Future<Either<Failure, UserModel>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (await (connectionChecker.isConnected) == false) {
        throw ServerException("No Internet Connection");
      }
      final user = await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (await (connectionChecker.isConnected) == false) {
        throw ServerException("No Internet Connection");
      }
      final user = await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getUserData() async {
    try {
      if (await (connectionChecker.isConnected) == false) {
        throw ServerException("No Internet Connection");
      }
      final user = await remoteDataSource.getUserData();

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> userLogOut() async {
    try {
      await remoteDataSource.userLogOut();
      return right("LogOut Successful");
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
