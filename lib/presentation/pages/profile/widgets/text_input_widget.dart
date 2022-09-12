import 'package:flutter/material.dart';

import '../../../i18n/languages.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget(
      {Key? key,
      this.isPassword = false,
      required this.controller,
      required this.label,
      required this.inputType})
      : super(key: key);

  final TextEditingController controller;
  final String label;
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
        labelText: label,
        filled: true,
        hintText: Languages.of(context)!.contactPageNameHintText,
        border: InputBorder.none,
      ),
    );
  }
}
