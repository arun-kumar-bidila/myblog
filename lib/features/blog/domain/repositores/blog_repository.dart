import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:myblog/core/error/failure.dart';
import 'package:myblog/features/blog/domain/entitites/blog.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required List<String> selectedTopics,
    required String posterId,
  });

  Future<Either<Failure, List<Blog>>> getAllBlogs();
}
