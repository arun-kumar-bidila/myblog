
import 'package:go_router/go_router.dart';
import 'package:myblog/core/cubits/app_user/app_user_cubit.dart';
import 'package:myblog/core/router/go_router_refresh_stream.dart';
import 'package:myblog/features/auth/presentation/pages/login_page.dart';
import 'package:myblog/features/auth/presentation/pages/signup_page.dart';
import 'package:myblog/features/blog/presentation/pages/blog_page.dart';
import 'package:myblog/splash_screen.dart';

GoRouter createRouter(AppUserCubit appUserCubit) {
  return GoRouter(
    initialLocation: '/splash',

    //  watches AppUserCubit — triggers redirect on every state change
    refreshListenable: GoRouterRefreshStream(appUserCubit.stream),

    redirect: (context, state) {
      final authState = appUserCubit.state;
      final location = state.matchedLocation;

      // still checking auth — stay on splash
      if (authState is AppUserInitial) {
        return '/splash';
      }

      // logged in — go to blog
      if (authState is AppUserLoggedIn) {
        if (location == '/splash' ||
            location == '/login' ||
            location == '/signup') {
          return '/blog'; // auto redirect
        }
      }

      // logged out — go to login
      if (authState is AppUserLoggedOut) {
        if (location == '/splash' ||
            location == '/blog') {
          return '/login'; //  auto redirect
        }
      }

      return null; // no redirect needed
    },

    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => SignupPage(),
      ),
      GoRoute(
        path: '/blog',
        builder: (context, state) => BlogPage(),
      ),
    ],
  );
}