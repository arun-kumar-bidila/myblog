import 'package:dio/dio.dart';
import 'package:myblog/core/error/exceptions.dart';

abstract interface class ProfileRemoteDatasource {
  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final Dio dio;
  ProfileRemoteDatasourceImpl(this.dio);
  @override
  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await dio.post(
        "/api/auth/changepassword",
        data: {"currentPassword": currentPassword, "newPassword": newPassword},
      );

      if (response.statusCode != 200) {
        throw ServerException(response.data["message"]);
      }
      return response.data["message"];
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
