import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../i18n/languages.dart';
import '../../../util/database_classes/item.dart';
import 'item_detail_tile.dart';

class ItemDetailWidget extends StatefulWidget {
  const ItemDetailWidget({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  State<ItemDetailWidget> createState() => _ItemDetailWidgetState();
}

class _ItemDetailWidgetState extends State<ItemDetailWidget> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isBookmarked = !isBookmarked;
                  //TODO: update DB
                });
              },
              icon: isBookmarked
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
              if(widget.item.subcategory != null && widget.item.explanation != null) ...[
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
            ],
          ),
        ),
      ),
    );
  }
}
