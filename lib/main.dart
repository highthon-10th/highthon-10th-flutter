import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highthon_10th/commons/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xfff7F5FA)),
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
    );
  }
}
