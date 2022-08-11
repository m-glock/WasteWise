import 'package:flutter/material.dart';

class CycleWidget extends StatefulWidget {
  const CycleWidget({Key? key}) : super(key: key);

  @override
  State<CycleWidget> createState() => _CycleWidgetState();
}

class _CycleWidgetState extends State<CycleWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Cycle"),);
  }
}