import 'package:flutter/material.dart';
import 'package:myblog/core/theme/app_pallete.dart';
import 'package:myblog/features/blog/domain/entitites/blog.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  const BlogCard({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Container(
    
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppPallete.borderColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .spaceBetween,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: blog.selectedTopics
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Chip(label: Text(e)),
                        ),
                      )
                      .toList(),
                ),
              ),
           
              Text(
                blog.title,
                style: TextStyle(
                  fontSize:24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

            ],
          ),
          Row(
            mainAxisAlignment: .end,
            children: [
              Text("1 min"),
            ],
          )
        ],
      ),
    );
  }
}
