import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:myblog/core/error/exceptions.dart';
import 'package:myblog/core/error/failure.dart';
import 'package:myblog/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:myblog/features/blog/data/models/blog_model.dart';
import 'package:myblog/features/blog/domain/entitites/blog.dart';
import 'package:myblog/features/blog/domain/repositores/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required List<String> selectedTopics,
    required String posterId,
  }) async {
    try {
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(image: image);

      BlogModel blog = BlogModel(
        id: "",
        title: title,
        content: content,
        imageUrl: imageUrl,
        posterId: posterId,
        selectedTopics: selectedTopics,
        updated: DateTime.now(),
      );

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blog: blog);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
