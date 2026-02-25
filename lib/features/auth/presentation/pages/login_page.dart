import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myblog/common/widgets/loader.dart';
import 'package:myblog/common/theme/app_pallete.dart';
import 'package:myblog/core/utils/show_snackbar.dart';
import 'package:myblog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:myblog/features/auth/presentation/widgets/auth_field.dart';
import 'package:myblog/features/auth/presentation/widgets/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
             constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: BlocConsumer<AuthBloc, AuthState>(
                  listenWhen: (previous, current) =>
                      current is AuthLoginFailure || current is AuthLoginSuccess,
                  listener: (context, state) {
                    if (state is AuthLoginFailure) {
                      showSnackBar(context, state.message);
                    }
                    if (state is AuthLoginSuccess) {
                      showSnackBar(context, "Login Successful");
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is AuthLoading ||
                      current is AuthInitial ||
                      current is AuthLoginFailure,
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Loader();
                    }
                    return Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: .center,
                        children: [
                
                          Image.asset("assets/logo_new.png",height: 100),
                          SizedBox(height: 30,),
                          Text(
                            "Sign In .",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30),
                
                          AuthField(hintText: "Email", controller: emailController),
                          SizedBox(height: 15),
                          AuthField(
                            hintText: "Password",
                            controller: passwordController,
                            isObscureText: true,
                          ),
                          SizedBox(height: 15),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     GestureDetector(
                          //       onTap: () {
                          //         context.push("/forgot-password");
                          //       },
                          //       child: Text(
                          //         "Forgot Password ?",
                          //         style: TextStyle(
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: 15),
                          AuthGradientButton(
                            buttonText: "Sign In",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  AuthLogin(
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
                              context.push('/signup');
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account ? ",
                                style: Theme.of(context).textTheme.titleMedium,
                                children: [
                                  TextSpan(
                                    text: "Sign Up",
                                    style: Theme.of(context).textTheme.titleMedium
                                        ?.copyWith(
                                          color: AppPallete.secondaryColor,
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
          ),
        ),
      ),
    );
  }
}
