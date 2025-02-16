import 'dart:convert';

import 'package:highthon_10th/main.dart';

import '../commons/dio.dart';

class LoginRepository {
  Future<String> login(String id, String pw) async {
    final response = await dio.post('auth/token',
        data: jsonEncode(
          {"username": id, "password": pw},
        ));
    prefs.setString('token', response.data['access_token']);
    print(response.data['access_token']);
    return response.data['access_token'];
  }
}
