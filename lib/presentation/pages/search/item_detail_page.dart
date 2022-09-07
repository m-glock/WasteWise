import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/search/widgets/item_detail_tile.dart';

import '../../util/database_classes/item.dart';
import '../../util/graphl_ql_queries.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
        actions: [
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
                  : const Icon(FontAwesomeIcons.bookmark))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.network(
                  widget.item.wasteBin.pictogramUrl,
                  color: widget.item.wasteBin.color,
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                ),
              ),
              if(widget.item.synonyms != null) ...[
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Center(
                  child: Text(
                      Languages.of(context)!.itemDetailSynonymsLabel +
                          widget.item.synonyms!,
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ],
              const Padding(padding: EdgeInsets.only(bottom: 30)),
              Text(
                  Languages.of(context)!.itemDetailMaterialLabel +
                      widget.item.material,
                  style: Theme.of(context).textTheme.bodyText1),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              Text(
                  Languages.of(context)!.itemDetailWasteBinLabel +
                      widget.item.wasteBin.title,
                  style: Theme.of(context).textTheme.bodyText1),
              const Padding(padding: EdgeInsets.only(bottom: 30)),
              Text(
                  Languages.of(context)!.itemDetailMoreInfoLabel +
                      widget.item.subcategory!,
                  style: Theme.of(context).textTheme.bodyText1),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              ItemDetailTile(
                  headerTitle:
                      Languages.of(context)!.itemDetailExplanationLabel,
                  expandedText: widget.item.explanation!),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              //TODO: get tips and preventions
              ItemDetailTile(
                  headerTitle: Languages.of(context)!.itemDetailTipsLabel,
                  expandedText: widget.item.explanation!),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              ItemDetailTile(
                  headerTitle: Languages.of(context)!.itemDetailPreventionLabel,
                  expandedText: widget.item.explanation!),
            ],
          ),
        ),
      ),
    );
  }
}
