import 'package:flutter/material.dart';
import 'package:myblog/core/theme/app_pallete.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppPallete.gradient1,
        strokeWidth: 5,
      ),
    );
  }
}
