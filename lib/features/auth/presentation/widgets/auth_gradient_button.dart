import 'package:flutter/material.dart';
import 'package:myblog/core/theme/app_pallete.dart';

class AuthGradientButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AuthGradientButton({super.key, required this.buttonText,required this.onPressed});

  @override
  State<AuthGradientButton> createState() => _AuthGradientButtonState();
}

class _AuthGradientButtonState extends State<AuthGradientButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
       color: AppPallete.buttonColor
      ),
      child: ElevatedButton(
        onPressed:widget.onPressed,

        style: ElevatedButton.styleFrom(
          fixedSize: Size(395, 55),
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
        ),
        child: Text(
          widget.buttonText,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,color: AppPallete.whiteColor),
        ),
      ),
    );
  }
}
