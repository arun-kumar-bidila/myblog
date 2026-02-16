import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:myblog/core/error/failure.dart';
import 'package:myblog/core/usecase/usecase.dart';
import 'package:myblog/features/blog/domain/entitites/blog.dart';

import 'package:myblog/features/blog/domain/repositores/blog_repository.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      selectedTopics: params.selectedTopics,
      posterId: params.posterId,
    );
  }
}

class UploadBlogParams {
  final File image;
  final String title;
  final String content;
  final List<String> selectedTopics;
  final String posterId;

  UploadBlogParams({
    required this.content,
    required this.image,
    required this.posterId,
    required this.selectedTopics,
    required this.title,
  });
}
