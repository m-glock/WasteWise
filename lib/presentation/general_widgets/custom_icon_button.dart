import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget{

  const CustomIconButton({Key? key, required this.onPressed, required this.icon, required this.padding}) : super(key: key);

  final VoidCallback onPressed;
  final Icon icon;
  final EdgeInsetsGeometry padding;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: InkWell(
        onTap: widget.onPressed,
        child: widget.icon,
      )
    );
  }
}