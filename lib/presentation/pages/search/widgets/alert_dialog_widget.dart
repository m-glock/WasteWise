import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/search/item_detail_page.dart';
import 'package:recycling_app/presentation/pages/search/widgets/tip_dialog_widget.dart';

import '../../../../model_classes/item.dart';
import '../../../../model_classes/tip.dart';
import '../../../../logic/database_access/graphl_ql_queries.dart';

class AlertDialogWidget {
  static Random rand = Random();

  static Future<void> showModal(
      BuildContext context, Item item, bool isCorrect) async {
    ParseUser? currentUser = await ParseUser.currentUser();
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
                if (currentUser != null)
                  IconButton(
                    onPressed: () async {
                      GraphQLClient client = GraphQLProvider.of(context).value;

                      // remove or add the bookmark depending on the bookmark state
                      bool success = isBookmarked
                          ? await GraphQLQueries.removeItemBookmark(
                              item.objectId, client)
                          : await GraphQLQueries.addItemBookmark(
                              item.objectId, client);

                      // change bookmark status if DB entry was successful
                      // or notify user if not
                      if (success) {
                        item.bookmarked = !isBookmarked;
                        setState(() {
                          isBookmarked = !isBookmarked;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              Languages.of(context)!.bookmarkingFailedText),
                        ));
                      }
                    },
                    icon: isBookmarked
                        ? const Icon(FontAwesomeIcons.solidBookmark)
                        : const Icon(FontAwesomeIcons.bookmark),
                  )
              ],
            ),
            contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            content: Wrap(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.file(
                        File(item.wasteBin.imageFilePath),
                        width: 80,
                        height: 80,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 10)),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: "${Languages.of(context)!.alertDialogPrompt} "
                              "${item.wasteBin.article ?? ""} ",
                          style: Theme.of(context).textTheme.bodyText2,
                          children: [
                            TextSpan(
                                text: item.wasteBin.title,
                                style: TextStyle(
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .fontFamily,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .fontSize,
                                  fontWeight: FontWeight.bold,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: isCorrect
                      ? Text(
                          Languages.of(context)!.alertDialogCorrectExplanation,
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      : Text(
                          Languages.of(context)!.alertDialogWrongExplanation),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actionsPadding: const EdgeInsets.symmetric(horizontal: 24),
            actions: [
              OutlinedButton(
                child: Text(Languages.of(context)!.alertDialogButtonMoreInfo),
                onPressed: () => _pressedButton(context, item, true),
              ),
              OutlinedButton(
                child: Text(Languages.of(context)!.alertDialogButtonDismiss),
                onPressed: () => _pressedButton(context, item, false),
              ),
            ],
          );
        });
      },
    );
  }

  static void _pressedButton(
      BuildContext context, Item item, bool moreInfo) async {
    Navigator.of(context).pop();
    int randomNumber = rand.nextInt(100);
    if (randomNumber > 70 && !moreInfo) {
      List<Tip> availableTips = [];
      availableTips.addAll(item.tips);
      availableTips.addAll(item.preventions);
      Tip tip = availableTips.elementAt(rand.nextInt(availableTips.length));
      TipDialogWidget.showModal(context, tip, item.subcategory!);
    } else if(!moreInfo){
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
      if (moreInfo){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItemDetailPage(item: item)),
        );
      }
    }
  }
}
