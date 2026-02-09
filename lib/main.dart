import 'package:flutter/material.dart';
import 'package:myblog/core/theme/theme.dart';
import 'package:myblog/features/auth/presentation/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyBlog',
      debugShowCheckedModeBanner:false,
      theme: AppTheme.darkThemeMode,
      home: SignupPage(),
    );
  }
}

