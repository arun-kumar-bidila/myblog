import 'dart:io';

import 'package:dio/dio.dart';
import 'package:myblog/core/error/exceptions.dart';
import 'package:myblog/features/blog/data/models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  Future<String> uploadBlogImage({required File image});

  Future<BlogModel> uploadBlog({required BlogModel blog});
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final Dio dio;
  BlogRemoteDataSourceImpl(this.dio);
  @override
  Future<BlogModel> uploadBlog({required BlogModel blog}) async {
    try {
      final response = await dio.post("/api/upload/blog", data: blog);

      if (response.statusCode == 200) {
        return BlogModel.fromJson(response.data["blog"]);
      } else {
        throw ServerException(response.data["message"]);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({required File image}) async {
    try {
      final formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path),
      });

      final response = await dio.post("/api/upload/blogimage", data: formData);

      if (response.statusCode == 200) {
        return response.data["imageUrl"];
      } else {
        throw ServerException(response.data["message"]);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
