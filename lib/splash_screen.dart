import 'package:flutter/material.dart';
import 'package:myblog/core/common/loader.dart';
import 'package:myblog/core/theme/app_pallete.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppPallete.splashScreenColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset("assets/logo.png", fit: BoxFit.contain),
            ),
            SizedBox(height: 40),
            Loader(),
          ],
        ),
      ),
    );
  }
}
