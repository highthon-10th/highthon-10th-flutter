import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/bottom_naviagtion_bar_provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentIndex = ref.watch(currentIndexProvider);

        return Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xffe9e9e9))),
            color: Colors.white,
          ),
          padding: const EdgeInsets.fromLTRB(77, 16, 77, 0),
          child: SafeArea(
            child: Row(
              children: [
                _buildNavItem(
                  context: context,
                  index: 0,
                  currentIndex: currentIndex,
                  icon: 'assets/image/home.png',
                  activeIcon: 'assets/image/selected_home.png',
                  label: '홈',
                  onTap: () => ref.read(currentIndexProvider.notifier).state = 0,
                ),
                _buildNavItem(
                  context: context,
                  index: 1,
                  currentIndex: currentIndex,
                  icon: 'assets/image/registration.png',
                  activeIcon: 'assets/image/selected_registration.png',
                  label: '장소 등록',
                  onTap: () => ref.read(currentIndexProvider.notifier).state = 1,
                ),
                _buildNavItem(
                  context: context,
                  index: 2,
                  currentIndex: currentIndex,
                  icon: 'assets/image/myPage.png',
                  activeIcon: 'assets/image/selected_myPage.png',
                  label: '마이페이지',
                  onTap: () => ref.read(currentIndexProvider.notifier).state = 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required int currentIndex,
    required String icon,
    required String activeIcon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isSelected = index == currentIndex;
    final color = isSelected ? const Color(0xffFF6DB6) : const Color(0xff6E6E6E);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: const Color(0xffFF6DB6).withOpacity(0.2),
        highlightColor: const Color(0xffFF6DB6).withOpacity(0.1),
        // 여기서 splash 효과 크기 조절
        radius: 20, // ink 효과 반경 조정
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                isSelected ? activeIcon : icon,
                width: 24,
                height: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Wanted',
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}