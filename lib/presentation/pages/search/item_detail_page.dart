import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/pages/search/widgets/basic_item_detail_widget.dart';
import 'package:recycling_app/presentation/pages/search/widgets/full_item_detail_widget.dart';

import '../../util/database_classes/item.dart';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({Key? key, required this.item, this.responseBody = ""})
      : super(key: key);

  final Item? item;
  final String responseBody;

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  late bool isBookmarked;

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.item?.bookmarked ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return widget.item != null
        ? FullItemDetailWidget(item: widget.item!)
        : BasicItemDetailWidget(responseBody: widget.responseBody);
  }
}
