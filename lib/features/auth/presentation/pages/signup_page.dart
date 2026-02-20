import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myblog/common/widgets/loader.dart';
import 'package:myblog/common/theme/app_pallete.dart';
import 'package:myblog/core/utils/show_snackbar.dart';
import 'package:myblog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:myblog/features/auth/presentation/widgets/auth_field.dart';
import 'package:myblog/features/auth/presentation/widgets/auth_gradient_button.dart';

class SignupPage extends StatefulWidget {

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
  void dispose() {
    nameController.dispose();
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
                  listener: (context, state) {
                    if (state is AuthSignUpFailure) {
                      showSnackBar(context, state.message);
                    } else if (state is AuthSignUpSuccess) {
                      showSnackBar(context, "Sign Up Success");
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is AuthLoading || current is AuthInitial || current is AuthSignUpFailure,
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
                              context.pop();
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
