import 'package:flutter/material.dart';
import 'package:myblog/common/theme/app_pallete.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  const CommonTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppPallete.greyColor),
      ),
      cursorColor: AppPallete.secondaryColor,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter $hintText";
        } else {
          return null;
        }
      },
    );
  }
}
