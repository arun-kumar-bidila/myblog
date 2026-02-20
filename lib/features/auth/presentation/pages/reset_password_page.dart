import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myblog/common/theme/app_pallete.dart';
import 'package:myblog/features/auth/presentation/widgets/auth_field.dart';
import 'package:myblog/features/auth/presentation/widgets/auth_gradient_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: AppPallete.whiteColor,
          ),
        ),
        
      ),
      body: SafeArea(
        child: Padding(
           padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
         
            children: [
              Text(
                "Reset Password .",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
          
              AuthField(hintText: "enter new password", controller: newPasswordController),
              SizedBox(height: 15),
              AuthField(
                hintText: "confirm new password",
                controller: confirmNewPasswordController,
                isObscureText: true,
              ),
              SizedBox(height: 15),
              AuthGradientButton(
                buttonText: "Verify",
                onPressed: () {
                  // if (formKey.currentState!.validate()) {
          
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
