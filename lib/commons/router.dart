import 'package:go_router/go_router.dart';
import 'package:highthon_10th/views/default_page.dart';

import '../views/default_page.dart';

final GoRouter routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const DefaultPage();
      },
    ),
  ],
);
