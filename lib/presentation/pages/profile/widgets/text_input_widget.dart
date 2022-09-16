import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget(
      {Key? key,
      this.isPassword = false,
      required this.controller,
      required this.hintText,
      required this.inputType})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: inputType,
      textCapitalization: TextCapitalization.none,
      autocorrect: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        hintText: hintText,
        border: InputBorder.none,
      ),
    );
  }
}
