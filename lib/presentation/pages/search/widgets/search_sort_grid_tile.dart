import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recycling_app/presentation/pages/search/item_detail_page.dart';
import 'package:recycling_app/presentation/util/waste_bin_category.dart';

class SearchSortGridTile extends StatefulWidget {
  const SearchSortGridTile(
      {Key? key,
      required this.category,
      required this.isCorrect,
      required this.itemObjectId})
      : super(key: key);

  final WasteBinCategory category;
  final bool isCorrect;
  final String itemObjectId;

  @override
  State<SearchSortGridTile> createState() => _SearchSortGridTileState();
}

class _SearchSortGridTileState extends State<SearchSortGridTile> {
  void _openModal() {
    //TODO open modal to show user whether they were right or wrong
    if (widget.isCorrect) {
    } else {}
  }

  Future<void> _showMyDialog() async {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ItemDetailPage(objectId: widget.itemObjectId)),
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

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.network(widget.category.pictogramUrl),
            Text(widget.category.title)
          ],
        ),
        onTap: _showMyDialog,
      ),
    );
  }
}
