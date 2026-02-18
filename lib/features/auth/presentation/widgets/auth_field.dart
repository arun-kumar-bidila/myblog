import 'package:flutter/material.dart';
import 'package:myblog/core/theme/app_pallete.dart';

class AuthField extends StatefulWidget {
  final String hintText;
  final bool isObscureText;
  final TextEditingController controller;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isObscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: AppPallete.greyColor),
      ),
      cursorColor: AppPallete.secondaryColor,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter ${widget.hintText}";
        } else {
          return null;
        }
      },
    );
  }
}
