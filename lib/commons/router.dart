import 'package:go_router/go_router.dart';
import 'package:highthon_10th/views/default_page.dart';
import 'package:highthon_10th/views/login/view/login_page.dart';
import 'package:highthon_10th/views/splash/view/splash_page.dart';

import '../views/default_page.dart';

final GoRouter routerConfig = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const DefaultPage();
      },
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => SplashPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginPage(),
        )
      ],
    ),
  ],
);
