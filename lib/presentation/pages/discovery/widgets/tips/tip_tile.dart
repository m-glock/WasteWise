import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/pages/discovery/tip_detail_page.dart';

import '../../../../i18n/languages.dart';
import '../../../../util/constants.dart';
import '../../../../util/custom_icon_button.dart';
import '../../../../util/database_classes/tip.dart';
import '../../../../util/graphl_ql_queries.dart';

class TipTile extends StatefulWidget {
  const TipTile({
    Key? key,
    required this.tip,
    required this.tipNumber,
    required this.tags,
  }) : super(key: key);

  final Tip tip;
  final int tipNumber;
  final List<String> tags;

  @override
  State<TipTile> createState() => _TipTileState();
}

class _TipTileState extends State<TipTile> {

  ParseUser? currentUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    ParseUser? current = await ParseUser.currentUser();
    setState(() {
      currentUser = current;
    });
  }

  void _bookmarkTip() async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    // remove or add the bookmark depending on the bookmark state
    bool success = widget.tip.isBookmarked
        ? await GraphQLQueries.removeTipBookmark(widget.tip.objectId, client)
        : await GraphQLQueries.addTipBookmark(widget.tip.objectId, client);

    // change bookmark status if DB entry was successful
    // or notify user if not
    if (success) {
      setState(() {
        widget.tip.isBookmarked = !widget.tip.isBookmarked;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Languages.of(context)!.bookmarkingFailedText),
      ));
    }
  }

  void _updateBookmarkInWidget() {
    setState(() {
      widget.tip.isBookmarked = !widget.tip.isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Constants.tileBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            if(currentUser != null)
              widget.tip.isBookmarked
                ? CustomIconButton(
                    onPressed: _bookmarkTip,
                    icon: const Icon(FontAwesomeIcons.solidBookmark),
                  )
                : CustomIconButton(
                    onPressed: _bookmarkTip,
                    icon: const Icon(FontAwesomeIcons.bookmark),
                  ),
            const Padding(padding: EdgeInsets.only(right: 15)),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TipDetailPage(
                        tip: widget.tip,
                        tipNumber: widget.tipNumber,
                        updateBookmarkInParent: _updateBookmarkInWidget,
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.tip.title,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 5)),
                          Row(children: [
                            ...widget.tags.map((tagName) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  margin: const EdgeInsets.only(right: 5),
                                  child: Text(
                                    tagName,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary),
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),),
                          ],)
                        ],
                      ),
                    ),
                    const Icon(FontAwesomeIcons.angleRight),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
