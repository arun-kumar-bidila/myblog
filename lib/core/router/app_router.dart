import 'package:go_router/go_router.dart';
import 'package:myblog/core/cubits/app_user/app_user_cubit.dart';
import 'package:myblog/core/router/go_router_refresh_stream.dart';
import 'package:myblog/features/auth/presentation/pages/login_page.dart';
import 'package:myblog/features/auth/presentation/pages/signup_page.dart';
import 'package:myblog/features/blog/presentation/pages/add_new_blog.dart';
import 'package:myblog/features/blog/presentation/pages/blog_page.dart';
import 'package:myblog/features/profile/presentation/pages/profile_page.dart';
import 'package:myblog/splash_screen.dart';

GoRouter createRouter(AppUserCubit appUserCubit) {
  return GoRouter(
    initialLocation: '/splash',

    //  watches AppUserCubit — triggers redirect on every state change
    refreshListenable: GoRouterRefreshStream(appUserCubit.stream),

    redirect: (context, state) {
      print(
        'REDIRECT FIRED — location: ${state.matchedLocation}, authState: ${appUserCubit.state}',
      );
      final authState = appUserCubit.state;
      final location = state.matchedLocation;

      final isAuthPage = location == '/login' || location == '/signup';


      final isSplash = location == '/splash';

      if (authState is AppUserInitial) {
        return isSplash ? null : '/splash';
      }

      if (authState is AppUserLoggedIn && isAuthPage) {
        return '/blog';
      }

      if (authState is AppUserLoggedOut && !isAuthPage  ) {
        return '/login';
      }

      return null;
    },

    routes: [
      GoRoute(path: '/splash', builder: (context, state) => SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => LoginPage()),
      GoRoute(path: '/signup', builder: (context, state) => SignupPage()),
      GoRoute(path: '/blog', builder: (context, state) => BlogPage()),
      GoRoute(path: '/add-blog', builder: (context, state) => AddNewBlog()),
      GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
    ],
  );
}
