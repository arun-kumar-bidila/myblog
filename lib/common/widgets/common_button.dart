import 'package:flutter/material.dart';
import 'package:myblog/common/theme/app_pallete.dart';

class CommonButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;
  const CommonButton({
    super.key,
    required this.buttonName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppPallete.secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(
              color: AppPallete.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
