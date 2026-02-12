import 'package:dio/dio.dart';
import 'package:myblog/core/error/exceptions.dart';
import 'package:myblog/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // final SupabaseClient supabaseClient;
  final Dio dio;
  AuthRemoteDataSourceImpl(
    // this.supabaseClient,
    this.dio,
  );
  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "/api/auth/login",
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data["user"]);
      } else {
        throw ServerException(response.data["message"]);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // final response = await supabaseClient.auth.signUp(
      //   email: email,
      //   password: password,
      //   data: {'name': name},
      // );

      final response = await dio.post(
        "/api/auth/signup",
        data: {"name": name, "email": email, "password": password},
      );

      if (response.statusCode == 201) {
        final data = response.data;
        return UserModel.fromJson(data["user"]);
      } else {
        throw ServerException(response.data["message"]);
      }
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }
}
