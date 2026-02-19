import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myblog/core/common/loader.dart';
import 'package:myblog/core/theme/app_pallete.dart';
import 'package:myblog/core/utils/show_snackbar.dart';
import 'package:myblog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:myblog/features/profile/presentation/widgets/logout_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppPallete.whiteColor),
          onPressed: () => context.go("/blog"),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLogOutFailure) {
                showSnackBar(context, "LogOut Failure");
              }
              if(state is AuthLogOutSuccess) {
                showSnackBar(context, "Logged Out Successfully");
              }
            },
            buildWhen: (previous, current) =>
                current is AuthLogOutLoading || current is AuthLogOutFailure ,
            builder: (context, state) {
              if (state is AuthLogOutLoading) {
                return Loader();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: AppPallete.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "A",
                        style: TextStyle(
                          color: AppPallete.whiteColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  LogoutButton(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
