import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../i18n/languages.dart';
import '../../../../util/constants.dart';

class ContentListWidget extends StatefulWidget {
  const ContentListWidget(
      {Key? key,
      required this.backgroundColor,
      required this.showMore,
      required this.title,
      required this.itemNames})
      : super(key: key);

  final Color backgroundColor;
  final Function showMore;
  final String title;
  final List<String> itemNames;

  @override
  State<ContentListWidget> createState() => _ContentListWidgetState();
}

class _ContentListWidgetState extends State<ContentListWidget> {
  String bulletPoint = "\u2022 ";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: Constants.tileBorderRadius,
      ),
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.only(top: 25, left: 25, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...widget.itemNames.map(
            (name) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  widget.title == Languages.of(context)!.wasteBinYesContentLabel
                      ? const Padding(padding: EdgeInsets.only(right: 5), child: Icon(FontAwesomeIcons.check, size: 20))
                      : const Padding(padding: EdgeInsets.only(right: 5), child: Icon(FontAwesomeIcons.xmark, size: 20)),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => {},
                child: Row(
                  children: const [
                    Icon(FontAwesomeIcons.angleRight, size: 12),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text("Mehr"),
                    )
                  ],
                ),
              ),
            ],
          ),*/
        ],
      ),
    );
  }
}