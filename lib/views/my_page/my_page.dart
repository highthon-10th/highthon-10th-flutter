import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highthon_10th/views/my_page/provider/favorite_provider.dart';

final favorite = StateProvider<String>((ref) => '');

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) => Scaffold(
        backgroundColor: Color(0xffF7F5Fa),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              spacing: 24,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '박유현 님',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Wanted',
                    color: Color(0xff3B3B3B),
                  ),
                ),
                _buildFavoriteProfile(ref),
                _buildAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteProfile(WidgetRef ref) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '최애',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Wanted',
            color: Colors.black,
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Color(0xffe9e9e9),
        ),
        SizedBox(
          height: 43,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '현재 최애',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Wanted',
                  color: Colors.black,
                ),
              ),
              Text(
                ref.read(currentFavorite),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Wanted',
                  color: Color(0xffB051FB),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 43,
            decoration: BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '최애 변경',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Wanted',
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 24,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildAccount() {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '계정',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Wanted',
            color: Colors.black,
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Color(0xffe9e9e9),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(),
            height: 43,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '등록 장소',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Wanted',
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 43,
            decoration: BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '로그아웃',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Wanted',
                    color: Color(0xffff4949),
                  ),
                ),
                Icon(
                  Icons.exit_to_app_rounded,
                  size: 24,
                  color: Color(0xffff4949),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
