import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myblog/common/theme/app_pallete.dart';
import 'package:myblog/common/widgets/common_button.dart';
import 'package:myblog/common/widgets/common_text_field.dart';
import 'package:myblog/common/widgets/loader.dart';
import 'package:myblog/core/utils/show_snackbar.dart';

import 'package:myblog/features/profile/presentation/bloc/profile_bloc.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

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
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileChangePasswordFailure) {
              showSnackBar(context, state.message);
            }

            if (state is ProfileChangePasswordSuccess) {
              showSnackBar(context, state.message);
              currentPasswordController.clear();
              newPasswordController.clear();

              formKey.currentState?.reset();
             
            }
          },
          builder: (context, state) {
            if (state is ProfileChangePasswordLoading) {
              return Loader();
            }
            return Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CommonTextField(
                      hintText: "enter current password",
                      controller: currentPasswordController,
                    ),
                    SizedBox(height: 24),
                    CommonTextField(
                      hintText: "enter new password",
                      controller: newPasswordController,
                    ),
                    SizedBox(height: 24),
                    CommonButton(
                      buttonName: "Change",
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<ProfileBloc>().add(
                            ProfileChangePassword(
                              currentPassword: currentPasswordController.text
                                  .trim(),
                              newPassword: newPasswordController.text.trim(),
                            ),
                          );
                        }
                        // context.read<AuthBloc>().add(AuthUserLogOut());
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
