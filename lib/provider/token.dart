import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highthon_10th/repository/login_repository.dart';

final token = StateNotifierProvider<TokenProvider, String>(
      (ref) => TokenProvider(ref: ref),
);
final id = StateProvider<TextEditingController>((ref) =>
    TextEditingController());
final pw = StateProvider<TextEditingController>((ref) =>
    TextEditingController());

class TokenProvider extends StateNotifier<String> {
  TokenProvider({required this.ref}) : super('');

  final Ref ref;

  Future<void> getToken() async {
    final idController = ref.read(id);
    final pwController = ref.read(pw);

    print(idController.text);
    print(pwController.text);

    final response = await LoginRepository().login(
      idController.text,
      pwController.text,
    );

    state = response; // 토큰 저장
  }
}