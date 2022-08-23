import 'package:flutter/material.dart';

import '../../util/constants.dart';

class TipPage extends StatefulWidget {
  const TipPage({Key? key, required this.tipTitle}) : super(key: key);

  final String tipTitle;

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tipTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.pagePadding),
        child: const Center(),
      ),
    );
  }
}