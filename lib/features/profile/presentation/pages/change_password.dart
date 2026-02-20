import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myblog/common/theme/app_pallete.dart';
import 'package:myblog/common/widgets/common_button.dart';
import 'package:myblog/common/widgets/common_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
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
        title: Text(
          "Change Password",
          style: TextStyle(
            fontSize: 16,
            color: AppPallete.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Column(
            children: [
              CommonTextField(
                hintText: "enter current password",
                controller: currentPasswordController,
              ),
              SizedBox(height: 24,),
              CommonTextField(
                hintText: "enter new password",
                controller: newPasswordController,
              ),
              SizedBox(height: 24,),
              CommonButton(buttonName: "Change", onTap: (){})
            ],
          ),
        ),
      ),
    );
  }
}
