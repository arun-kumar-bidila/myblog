import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myblog/core/theme/theme.dart';
import 'package:myblog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:myblog/features/auth/data/repository/auth_repository_impl.dart';
import 'package:myblog/features/auth/domain/usecases/user_signup.dart';
import 'package:myblog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:myblog/features/auth/presentation/pages/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final supabase = await Supabase.initialize(
  //   url: AppSecrets.supabaseUrl,
  //   anonKey: AppSecrets.anonKey,
  // );

  final dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:3001",
      headers: {"Content-Type": "application/json"},
    ),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            userSignUp: UserSignup(
              AuthRepositoryImpl(AuthRemoteDataSourceImpl(dio)),
            ),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
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
