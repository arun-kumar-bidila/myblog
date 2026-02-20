import 'package:dio/dio.dart';
import 'package:myblog/core/error/exceptions.dart';
import 'package:myblog/features/blog/data/models/blog_model.dart';

abstract interface class ProfileRemoteDatasource {
  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<List<BlogModel>> fetchBlogsByUser();
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

  @override
  Future<List<BlogModel>> fetchBlogsByUser() async {
    try {
      final response = await dio.get("/api/blog/getuserblogs");
      if (response.statusCode != 200) {
        throw ServerException(response.data["message"]);
      }
      final blogsData = response.data["blogs"];
      if (blogsData == null) {
        return [];
      }

      final List<Map<String, dynamic>> blogsJson =
          List<Map<String, dynamic>>.from(blogsData);

      return blogsJson.map((blog) => BlogModel.fromJson(blog)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
