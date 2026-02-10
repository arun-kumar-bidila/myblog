import 'package:flutter/material.dart';
import 'package:myblog/core/secrets/app_secrets.dart';
import 'package:myblog/core/theme/theme.dart';
import 'package:myblog/features/auth/presentation/pages/signup_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyBlog',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: SignupPage(),
    );
  }
}
