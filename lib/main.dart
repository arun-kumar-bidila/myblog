import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myblog/common/cubits/app_user/app_user_cubit.dart';
import 'package:myblog/common/theme/theme_cubit.dart';
import 'package:myblog/core/router/app_router.dart';
import 'package:myblog/common/theme/apptheme.dart';
import 'package:myblog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:myblog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:myblog/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:myblog/firebase_options.dart';
import 'package:myblog/init_dependencies.dart';

Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint('Background message:${message.notification?.title}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<BlogBloc>()),
        BlocProvider(create: (_) => serviceLocator<ProfileBloc>()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = createRouter(serviceLocator<AppUserCubit>());
    serviceLocator<AuthBloc>().add(IsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,

          theme: AppTheme.lightThemeMode,
          darkTheme: AppTheme.darkThemeMode,
          themeMode: themeMode,

          routerConfig: _router,
        );
      },
    );
  }
}
