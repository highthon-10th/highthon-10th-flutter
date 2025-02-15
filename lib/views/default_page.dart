import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highthon_10th/providers/bottom_naviagtion_bar_provider.dart';
import 'package:highthon_10th/views/main/main_screen.dart';
import 'package:highthon_10th/views/my_page/my_page.dart';
import 'package:highthon_10th/views/registration/registration_page.dart';

import '../commons/bottom_navigation_bar.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({super.key});

  static const List<Widget> pages = [
    MainScreen(),
    RegistrationPage(),
    MyPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          body: pages[ref.watch(currentIndexProvider)],
          bottomNavigationBar: CustomBottomNavBar(),
        );
      },
    );
  }
}
