import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../i18n/languages.dart';
import '../../../../util/constants.dart';

class ContentListWidget extends StatelessWidget {
  const ContentListWidget(
      {Key? key,
      required this.backgroundColor,
      required this.title,
      required this.itemNames})
      : super(key: key);

  final Color backgroundColor;
  final String title;
  final List<String> itemNames;
  final String bulletPoint = "\u2022 ";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: Constants.tileBorderRadius,
      ),
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...itemNames.map(
            (name) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  title == Languages.of(context)!.wasteBinYesContentLabel
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
        ],
      ),
    );
  }
}
