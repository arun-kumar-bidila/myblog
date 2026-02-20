import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myblog/common/theme/app_pallete.dart';
import 'package:myblog/core/utils/calcute_reading_time.dart';
import 'package:myblog/features/blog/domain/entitites/blog.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;

  const BlogCard({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push( "/blog-viewer", extra: blog);
      },
      child: Container(
        height: 300,
       
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppPallete.borderColor, width: 2),
          // color: color,
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  blog.imageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        blog.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppPallete.whiteColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),

                      Text(
                        " ${calculateReadingTime(blog.content)} min",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppPallete.whiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4,),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: blog.selectedTopics
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Chip(
                                label: Text(
                                  e,
                                  style: TextStyle(
                                    color: AppPallete.blackColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                backgroundColor: AppPallete.secondaryColor,
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
