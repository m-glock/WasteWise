import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/pages/search/item_detail_page.dart';

import '../../../util/database_classes/item.dart';

class AlertDialogWidget{
  static Future<void> showModal(BuildContext context, Item item, bool isCorrect) async {
    print("is correct: $isCorrect");
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Learn more'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ItemDetailPage(item: item)),
                );
              },
            ),
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
