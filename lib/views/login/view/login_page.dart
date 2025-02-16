import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:highthon_10th/provider/token.dart';
import 'package:highthon_10th/views/login/widgets/auth_textfield.dart';

final loadingProvider = StateProvider<bool>((ref) => false);

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/image/logo.png',
                  width: 282,
                ),
              ),
              const SizedBox(height: 20),
              AuthTextField(
                controller: ref.read(id),
                hintText: '아이디를 입력하세요',
                textFieldState: TextFieldState.email,
              ),
              const SizedBox(height: 12),
              AuthTextField(
                controller: ref.read(pw),
                hintText: '비밀번호를 입력하세요',
                textFieldState: TextFieldState.password,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: isLoading
                    ? null
                    : () async {
                  ref.read(loadingProvider.notifier).state = true;
                  await ref.read(token.notifier).getToken();
                  ref.read(loadingProvider.notifier).state = false;

                  if (ref.read(token) != '') {
                    context.go('/');
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 120,
                    vertical: 16,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isLoading ? Colors.grey : const Color(0xffB051FB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text(
                    '등록하기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Wanted',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}