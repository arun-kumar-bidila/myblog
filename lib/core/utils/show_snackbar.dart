import 'package:flutter/material.dart';
import 'package:myblog/common/theme/app_pallete.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: AppPallete.secondaryColor,
        // behavior: SnackBarBehavior.floating,
        content: Center(
          child: Text(
            content,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppPallete.whiteColor,
            ),
          ),
        ),
      ),
    );
}
