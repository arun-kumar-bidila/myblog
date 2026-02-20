import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myblog/common/theme/app_pallete.dart';
import 'package:myblog/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EnterCodePage extends StatefulWidget {
  const EnterCodePage({super.key});

  @override
  State<EnterCodePage> createState() => _EnterCodePageState();
}

class _EnterCodePageState extends State<EnterCodePage> {
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
                "Enter Code .",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 30),

              MaterialPinField(
                length: 4,
                
                theme: MaterialPinTheme(
                  spacing: 20,
                  borderColor: AppPallete.secondaryColor,

                  fillColor: AppPallete.transparentColor,
                  focusedFillColor: AppPallete.transparentColor,
                  focusedBorderColor: AppPallete.secondaryColor,
                  cursorColor: AppPallete.secondaryColor,
                  filledFillColor: AppPallete.transparentColor,
                   borderWidth: 2
                ),
              ),

              SizedBox(height: 30),
              AuthGradientButton(
                buttonText: "Verify",
                onPressed: () {
                  context.push('/reset-password');
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
