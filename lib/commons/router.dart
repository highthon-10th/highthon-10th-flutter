import 'package:go_router/go_router.dart';
import 'package:highthon_10th/views/main/main_screen.dart';

final GoRouter routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const MainScreen();
      },
    ),
  ],
);
