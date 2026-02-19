import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myblog/core/theme/app_pallete.dart';
import 'package:myblog/features/auth/presentation/bloc/auth_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AuthBloc>().add(AuthUserLogOut());
      },
      child: Container(
        width: double.infinity,
        padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppPallete.secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child:  Center(
          child: Text(
            "Logout",
            style: TextStyle(color: AppPallete.whiteColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}