import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myblog/core/common/loader.dart';
import 'package:myblog/core/theme/app_pallete.dart';
import 'package:myblog/core/utils/show_snackbar.dart';
import 'package:myblog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:myblog/features/auth/presentation/pages/login_page.dart';
import 'package:myblog/features/auth/presentation/widgets/auth_field.dart';
import 'package:myblog/features/auth/presentation/widgets/auth_gradient_button.dart';

class SignupPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => SignupPage());
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackBar(context, state.message);
              } else if (state is AuthSuccess) {
                showSnackBar(context, "Sign Up Success");
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return Loader();
              }
              return Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      "Sign Up .",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    AuthField(hintText: "Name", controller: nameController),
                    SizedBox(height: 15),
                    AuthField(hintText: "Email", controller: emailController),
                    SizedBox(height: 15),
                    AuthField(
                      hintText: "Password",
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    SizedBox(height: 15),
                    AuthGradientButton(
                      buttonText: "Sign Up",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            AuthSignUp(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
                         
                      },
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, LoginPage.route());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account ? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: "Sign In",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppPallete.gradient1,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
