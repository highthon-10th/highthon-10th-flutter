import 'package:flutter/material.dart';

class TextFieldComponent extends StatefulWidget {
  final TextEditingController controller;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final TextStyle textStyle;
  final Color cursorColor;
  final EdgeInsetsGeometry contentPadding;
  final String hintText;
  final TextStyle hintStyle;
  final Color hintColor;

  const TextFieldComponent({
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
  });

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: widget.textStyle,
      cursorColor: widget.cursorColor,
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
