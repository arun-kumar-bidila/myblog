import 'package:flutter/material.dart';
import 'package:myblog/common/theme/app_pallete.dart';
import 'package:shimmer/shimmer.dart';

class BlogImageSkeleton extends StatelessWidget {
  const BlogImageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppPallete.greyColor.withAlpha(51),
      highlightColor: AppPallete.whiteColor,
      child: Container(
        height: 200,
        width: double.infinity,
        color: AppPallete.greyColor.withAlpha(83),
      ),
    );
  }
}
