import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget{

  const CustomIconButton({Key? key, required this.onPressed, required this.icon}) : super(key: key);

  final VoidCallback onPressed;
  final Icon icon;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: widget.onPressed,
        splashRadius: 0.1,
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.all(0),
        icon: widget.icon,
    );
  }
}