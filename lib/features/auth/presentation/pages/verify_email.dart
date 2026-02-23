import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myblog/common/theme/app_pallete.dart';
import 'package:myblog/common/widgets/loader.dart';
import 'package:myblog/core/utils/show_snackbar.dart';
import 'package:myblog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:myblog/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmail extends StatefulWidget {
  final String email;
  const VerifyEmail({super.key, required this.email});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final _otpController = PinInputController();
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
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSignUpFailure) {
                showSnackBar(context, state.message);
              }
              if (state is AuthSignUpSuccess) {
                showSnackBar(context, "Sign Up Success");
              }
            },
            buildWhen: (previous, current) =>
                current is AuthLoading || current is AuthSignUpFailure,
            builder: (context, state) {
              if (state is AuthLoading) {
                return Loader();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    "Verify Email .",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 30),

                  MaterialPinField(
                    pinController: _otpController,
                    length: 4,

                    theme: MaterialPinTheme(
                      spacing: 20,
                      borderColor: AppPallete.secondaryColor,

                      fillColor: AppPallete.transparentColor,
                      focusedFillColor: AppPallete.transparentColor,
                      focusedBorderColor: AppPallete.secondaryColor,
                      cursorColor: AppPallete.secondaryColor,
                      filledFillColor: AppPallete.transparentColor,
                      borderWidth: 2,
                    ),
                  ),

                  SizedBox(height: 30),
                  AuthGradientButton(
                    buttonText: "Verify",
                    onPressed: () {
                      if (_otpController.text.length != 4) {
                        showSnackBar(context, "Enter Valid Otp");
                        return;
                      }
                      context.read<AuthBloc>().add(
                        AuthVerifyEmailOtp(
                          email: widget.email,
                          otp: _otpController.text.trim(),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
