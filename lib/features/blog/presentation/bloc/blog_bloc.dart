import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myblog/core/usecase/usecase.dart';
import 'package:myblog/features/blog/domain/entitites/blog.dart';
import 'package:myblog/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:myblog/features/blog/domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
    : _uploadBlog = uploadBlog,
      _getAllBlogs = getAllBlogs,
      super(BlogInitial()) {
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAll>(_onBlogFetchAll);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    emit(BlogLoading());

    final res = await _uploadBlog(
      UploadBlogParams(
        content: event.content,
        image: event.image,
        posterId: event.posterId,
        selectedTopics: event.selectedTopics,
        title: event.title,
      ),
    );

    res.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }

  void _onBlogFetchAll(BlogFetchAll event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final res = await _getAllBlogs(NoParams());
   
    res.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) =>emit( BlogDisplaySuccess(r)),
    );
  }
}
