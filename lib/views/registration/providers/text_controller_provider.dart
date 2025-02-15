import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final name =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final address =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final description =
    StateProvider<TextEditingController>((ref) => TextEditingController());

final category = StateProvider<String>((ref) => '');
