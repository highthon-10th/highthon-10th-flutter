import 'package:flutter/material.dart';

enum TextFieldState {
  basic,
  email,
  password,
  search,
}

class AuthTextField extends StatefulWidget {
  final TextFieldState textFieldState;
  final TextEditingController controller;
  final String? validator;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final TextStyle textStyle;
  final Color cursorColor;
  final EdgeInsetsGeometry contentPadding;
  final String hintText;
  final TextStyle hintStyle;
  final Color hintColor;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.textStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Wanted',
      color: Colors.black,
    ),
    this.cursorColor = Colors.black,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 15,
      horizontal: 16,
    ),
    this.hintStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Wanted',
      color: Color(0xff6e6e6e),
    ),
    this.hintColor = const Color(0xff6e6e6e),
    required this.textFieldState,
    this.validator,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _isObscureText = true;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '아이디를 입력하세요.';
    }
    return null; // 유효하면 null 반환
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력하세요.';
    }
    if (value.length < 4) {
      return '비밀번호는 최소 4자 이상이어야 합니다.';
    }
    return null; // 통과하면 null 반환
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: (value) {
        if (widget.textFieldState == TextFieldState.email) {
          return _validateEmail(value);
        } else if (widget.textFieldState == TextFieldState.password) {
          return _validatePassword(value);
        } else if (widget.textFieldState == TextFieldState.basic &&
            widget.validator != null) {
          return widget.validator;
        } else {
          return null;
        }
      },
      style: widget.textStyle,
      cursorColor: widget.cursorColor,
      obscureText: widget.textFieldState == TextFieldState.password
          ? _isObscureText
          : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.backgroundColor,
        contentPadding: widget.contentPadding,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle.copyWith(
          color: widget.hintColor,
        ),
        border: OutlineInputBorder(
          borderRadius: widget.borderRadius,
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
