import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myblog/features/blog/domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  BlogBloc({required UploadBlog uploadBlog})
    : _uploadBlog = uploadBlog,
      super(BlogInitial()) {
    on<BlogUpload>(_onBlogUpload);
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
      (r) => emit(BlogSuccess()),
    );
  }
}
