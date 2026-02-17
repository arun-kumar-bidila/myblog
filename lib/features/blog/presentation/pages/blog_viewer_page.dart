import 'package:flutter/material.dart';
import 'package:myblog/core/theme/app_pallete.dart';
import 'package:myblog/core/utils/format_date.dart';
import 'package:myblog/features/blog/domain/entitites/blog.dart';

class BlogViewerPage extends StatelessWidget {
  final Blog blog;
  static Route route(Blog blog) =>
      MaterialPageRoute(builder: (_) => BlogViewerPage(blog: blog));
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    blog.title,
                    style: TextStyle(
                      fontSize: 24,
                      color: AppPallete.whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16),
            
                  Text(
                    "Published on : ${formatDate(blog.updated)}",
                    style: TextStyle(fontSize: 12, color: AppPallete.whiteColor),
                  ),
                  SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      blog.imageUrl!,
                      width: .infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
            
                  SizedBox(height: 16),
                  Text(
                    blog.content,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppPallete.whiteColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
