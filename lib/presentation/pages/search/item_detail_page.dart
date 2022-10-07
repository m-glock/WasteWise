import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/tip_detail_page.dart';
import 'package:recycling_app/presentation/pages/search/widgets/item_detail_tile.dart';

import '../../../model_classes/item.dart';
import '../../../model_classes/tip.dart';
import '../../../logic/database_access/graphl_ql_queries.dart';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage(
      {Key? key, required this.item, this.updateBookmarkInParent})
      : super(key: key);

  final Item item;
  final Function? updateBookmarkInParent;

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  ParseUser? currentUser;
  String bulletPoint = "\u2022 ";

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

  void _updateBookmark() async {
    GraphQLClient client = GraphQLProvider.of(context).value;

    // remove or add the bookmark depending on the bookmark state
    bool success = widget.item.bookmarked
        ? await GraphQLQueries.removeItemBookmark(widget.item.objectId, client)
        : await GraphQLQueries.addItemBookmark(widget.item.objectId, client);

    // change bookmark status if DB entry was successful
    // or notify user if not
    if (success) {
      setState(() {
        widget.item.bookmarked = !widget.item.bookmarked;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Languages.of(context)!.bookmarkingFailedText),
      ));
    }
  }

  Widget _getTipLinks(bool prevention) {
    List<Tip> tipList = prevention ? widget.item.preventions : widget.item.tips;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...tipList.map(
          (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bulletPoint + tip.title,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize:
                              Theme.of(context).textTheme.bodyText1!.fontSize,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .fontFamily),
                    ),
                  ],
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TipDetailPage(tip: tip),
                  ),
                ),
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
        actions: [
          if (currentUser != null)
            IconButton(
              onPressed: () {
                if (widget.updateBookmarkInParent == null) {
                  _updateBookmark();
                } else {
                  widget.updateBookmarkInParent!();
                  setState(() {
                    widget.item.bookmarked = !widget.item.bookmarked;
                  });
                }
              },
              icon: widget.item.bookmarked
                  ? const Icon(FontAwesomeIcons.solidBookmark)
                  : const Icon(FontAwesomeIcons.bookmark),
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.file(
                  File(widget.item.wasteBin.imageFilePath),
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                ),
              ),
              if (widget.item.synonyms != null) ...[
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Center(
                  child: Text(
                      Languages.of(context)!.itemDetailSynonymsLabel +
                          widget.item.synonyms!,
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ],
              const Padding(padding: EdgeInsets.only(bottom: 30)),
              Text.rich(TextSpan(
                  text: Languages.of(context)!.itemDetailWasteBinLabel,
                  style: Theme.of(context).textTheme.labelMedium,
                  children: [
                    TextSpan(
                        text: widget.item.wasteBin.title,
                        style: Theme.of(context).textTheme.bodyText1)
                  ])),
              const Padding(padding: EdgeInsets.only(bottom: 40)),
              Text(
                  Languages.of(context)!.itemDetailMoreInfoLabel +
                      widget.item.subcategory!,
                  style: Theme.of(context).textTheme.headline2),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              ItemDetailTile(
                headerTitle: Languages.of(context)!.itemDetailExplanationLabel,
                expandedWidget: Text(
                  widget.item.explanation!,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              if(widget.item.tips.isNotEmpty) ...[
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                ItemDetailTile(
                  headerTitle: Languages.of(context)!.itemDetailTipsLabel,
                  expandedWidget: _getTipLinks(false),
                ),
              ],
              if(widget.item.preventions.isNotEmpty) ...[
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                ItemDetailTile(
                  headerTitle: Languages.of(context)!.itemDetailPreventionLabel,
                  expandedWidget: _getTipLinks(true),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
