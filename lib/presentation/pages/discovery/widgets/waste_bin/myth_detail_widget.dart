import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../i18n/languages.dart';
import '../../../../util/myth.dart';

class MythDetailWidget extends StatefulWidget {
  const MythDetailWidget({Key? key, required this.myth}) : super(key: key);

  final Myth myth;

  @override
  State<MythDetailWidget> createState() => _MythDetailWidgetState();
}

class _MythDetailWidgetState extends State<MythDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.center,
          ),
          header: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              children: [
                const Icon(Icons.question_mark_rounded, size: 30),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Expanded(
                  child: Text(
                    widget.myth.question,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ],
            ),
          ),
          collapsed: const SizedBox.shrink(),
          expanded: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(FontAwesomeIcons.exclamation, size: 30),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          widget.myth.isCorrect
                              ? Languages.of(context)!.wasteBinMythCorrect
                              : Languages.of(context)!.wasteBinMythIncorrect,
                          style: Theme.of(context).textTheme.headline3),
                      const Padding(padding: EdgeInsets.only(bottom: 5)),
                      Text(widget.myth.answer),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
