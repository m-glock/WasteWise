import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MythListWidget extends StatefulWidget {
  const MythListWidget({Key? key, required this.question, required this.answer})
      : super(key: key);

  final String question;
  final String answer;

  @override
  State<MythListWidget> createState() => _MythListWidgetState();
}

class _MythListWidgetState extends State<MythListWidget> {
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
          header: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(Icons.question_mark_rounded),
                const Padding(padding: EdgeInsets.only(right: 5)),
                Text(
                  widget.question,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
          ),
          collapsed: Container(),
          expanded: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(FontAwesomeIcons.exclamation),
                const Padding(padding: EdgeInsets.only(right: 5)),
                Expanded(child: Text(widget.answer)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
