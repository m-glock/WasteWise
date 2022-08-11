import 'package:flutter/material.dart';

class MythWidget extends StatefulWidget {
  const MythWidget({Key? key}) : super(key: key);

  @override
  State<MythWidget> createState() => _MythWidgetState();
}

class _MythWidgetState extends State<MythWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Myth"),);
  }
}