import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../feature/gpt_clone/presentation/pages/pages.dart';
import '../core_barrel.dart';

part 'go_router.g.dart';

enum ScreenPath {
  splash,
  home,
  login,
  about,
  contact,

  profileSetting,
}

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    routes: [
      //splash
      GoRoute(
        path: '/',
        name: ScreenPath.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      // Login
      GoRoute(
        path: '/login',
        name: ScreenPath.login.name,
        builder: (context, state) => const LoginPage(),
      ),

      // Home
      GoRoute(
        path: '/home',
        name: ScreenPath.home.name,
        builder: (context, state) => const HomePage(),
      ),
      // Profile Setting
      GoRoute(
        path: '/profile-setting',
        name: ScreenPath.profileSetting.name,
        builder: (context, state) => const ProfileSettingPage(),
      ),
      //  About
      // GoRoute(
      //   path: '/about',
      //   pageBuilder: (context, state) => MaterialPage(child: Container()),
      // ),
      // // Contact
      // GoRoute(
      //   path: '/contact',
      //   pageBuilder: (context, state) => MaterialPage(child: Container()),
      // ),
    ],
  );
}
