import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  TextInputWidget({Key? key, this.isPassword = false, required this.controller, required this.label,  required this.inputType}) : super(key: key);

  final TextEditingController controller;
  final String label;
  bool isPassword;
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
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          labelText: label),
    );
  }

}