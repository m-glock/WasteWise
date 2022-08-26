import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/search/item_detail_page.dart';

import '../../../util/database_classes/item.dart';

class AlertDialogWidget {
  static Future<void> showModal(BuildContext context, Item item, bool isCorrect,
      Function bookmarkItem) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        bool isBookmarked = item.bookmarked;

        return StatefulBuilder(builder:
            (BuildContext context, void Function(void Function()) setState) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isCorrect
                    ? Text(Languages.of(context)!.alertDialogCorrectTitle)
                    : Text(Languages.of(context)!.alertDialogWrongTitle),
                IconButton(
                    onPressed: () {
                      setState(() {
                        item.bookmarked = !item.bookmarked;
                        isBookmarked = item.bookmarked;
                      });
                      bookmarkItem();
                    },
                    icon: isBookmarked
                        ? const Icon(FontAwesomeIcons.solidBookmark)
                        : const Icon(FontAwesomeIcons.bookmark))
              ],
            ),
            contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            content: SizedBox(
              height: 120,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SvgPicture.network(
                          item.wasteBin.pictogramUrl,
                          color: item.wasteBin.color,
                          width: 80,
                          height: 80,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 10)),
                      Expanded(
                        child: Text(Languages.of(context)!.alertDialogPrompt +
                            item.wasteBin.title),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  Expanded(
                    child: isCorrect
                        ? Text(Languages.of(context)!
                            .alertDialogCorrectExplanation)
                        : Text(
                            Languages.of(context)!.alertDialogWrongExplanation),
                  ),
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actionsPadding: const EdgeInsets.symmetric(horizontal: 24),
            actions: [
              TextButton(
                child: Text(Languages.of(context)!.alertDialogButtonMoreInfo),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ItemDetailPage(item: item)),
                  );
                },
              ),
              TextButton(
                child: Text(Languages.of(context)!.alertDialogButtonDismiss),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      },
    );
  }
}
