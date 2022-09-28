import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../i18n/languages.dart';
import '../../../../util/constants.dart';

class ContentListWidget extends StatefulWidget {
  ContentListWidget(
      {Key? key,
      required this.backgroundColor,
      required this.title,
      required this.itemNames})
      : super(key: key);

  final Color backgroundColor;
  final String title;
  final List<String> itemNames;

  @override
  State<ContentListWidget> createState() => _ContentListWidgetState();
}

class _ContentListWidgetState extends State<ContentListWidget> {
  final String bulletPoint = "\u2022 ";

  bool expanded = false;

  Widget _getWidget(BuildContext context, {int? itemLimit}){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: Constants.tileBorderRadius,
      ),
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ...widget.itemNames.getRange(0, itemLimit ?? widget.itemNames.length).map(
                (name) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  widget.title == Languages.of(context)!.wasteBinYesContentLabel
                      ? const Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(FontAwesomeIcons.check, size: 20))
                      : const Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(FontAwesomeIcons.xmark, size: 20)),
                  Expanded(
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            child: Text(expanded
                ? Languages.of(context)!.wasteBinShowLessLabel
                : Languages.of(context)!.wasteBinShowMoreLabel,
            ),
            onPressed: () => setState(() {
              expanded = !expanded;
            }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return expanded
        ? _getWidget(context)
        : _getWidget(context, itemLimit: 5);
  }
}
