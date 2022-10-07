import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../model_classes/myth.dart';
import '../../../../i18n/languages.dart';

class MythDetailWidget extends StatelessWidget {
  const MythDetailWidget({Key? key, required this.myth}) : super(key: key);

  final Myth myth;

  void _openLink() async {
    Uri uri = Uri.parse(myth.sourceUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

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
                    myth.question,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline3!.fontSize,
                      fontFamily: Theme.of(context).textTheme.headline3!.fontFamily,
                    ),
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
                const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          myth.isCorrect
                              ? Languages.of(context)!.wasteBinMythCorrect
                              : Languages.of(context)!.wasteBinMythIncorrect,
                          style: Theme.of(context).textTheme.headline3),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                      Text(myth.answer),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      Row(
                        children: [
                          const Icon(FontAwesomeIcons.link, size: 20),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          InkWell(
                            onTap: _openLink,
                            child: Text(
                              myth.sourceName,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      )
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
