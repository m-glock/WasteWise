import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/pages/discovery/tip_detail_page.dart';

import '../../../../../model_classes/tip.dart';
import '../../../../general_widgets/custom_icon_button.dart';
import '../../../../i18n/languages.dart';
import '../../../../../logic/util/constants.dart';
import '../../../../../logic/database_access/graphl_ql_queries.dart';

class TipTile extends StatefulWidget {
  const TipTile({
    Key? key,
    required this.tip,
    required this.tipTypeTag,
    required this.wasteBinTags,
  }) : super(key: key);

  final Tip tip;
  final String tipTypeTag;
  final List<String> wasteBinTags;

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

  Widget _getTagRow(List<String> tags) {
    return Row(
      children: [
        ...tags.map(
              (tagName) => Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.only(right: 5),
            child: Text(
              tagName,
              style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSecondary),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withAlpha(180),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Constants.tileBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            if (currentUser != null)
              widget.tip.isBookmarked
                  ? CustomIconButton(
                      padding: const EdgeInsets.only(right: 10),
                      onPressed: _bookmarkTip,
                      icon: const Icon(FontAwesomeIcons.solidBookmark),
                    )
                  : CustomIconButton(
                      padding: const EdgeInsets.only(right: 10),
                      onPressed: _bookmarkTip,
                      icon: const Icon(FontAwesomeIcons.bookmark),
                    ),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TipDetailPage(
                        tip: widget.tip,
                        updateBookmarkInParent: _updateBookmarkInWidget,
                      ),
                    ),
                  );
                },
                child: Row(
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
                          if(widget.wasteBinTags.length > 1)
                            Column(
                              children: [
                                _getTagRow([
                                  widget.tipTypeTag,
                                  widget.wasteBinTags.first
                                ]),
                                const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                                _getTagRow([
                                  ...widget.wasteBinTags.sublist(1)
                                ]),
                              ],
                            )
                          else
                          _getTagRow([
                            widget.tipTypeTag,
                            widget.wasteBinTags.first
                          ]),
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
