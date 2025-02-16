import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController ac = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 600));
  late CurvedAnimation animation =
      CurvedAnimation(parent: ac, curve: Curves.easeOutCirc);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () => ac.forward());
    initData();
  }

  initData() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    String? token = prefs.getString('token');
    if (token == null) {
      Future.delayed(Duration(milliseconds: 2000), () => context.go('/login'));
    } else {
      Future.delayed(Duration(milliseconds: 2000), () => context.go('/'));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ac.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return Scaffold(
          body: Center(
            child: Transform.translate(
              offset: Offset(0, -80 + 80 * animation.value),
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/image/logo.png',
                  width: 282,
                ),
              ),
            ),
          ),
        );
      },
      animation: animation,
    );
  }
}
