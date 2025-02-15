import 'package:dio/dio.dart';

const baseUrl = 'http://167.71.249.204/';
const kakaoRestKey = '2db693a433d1b85373a4e70b37ab8289';

final Dio dio = Dio(
  BaseOptions(baseUrl: baseUrl),
);
