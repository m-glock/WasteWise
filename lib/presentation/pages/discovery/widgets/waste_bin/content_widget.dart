import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/waste_bin/content_list_widget.dart';
import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({Key? key, required this.category}) : super(key: key);

  final WasteBinCategory category;

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            ContentListWidget(
                backgroundColor: const Color.fromARGB(255, 216, 227, 204),
                title: Languages.of(context)!.wasteBinYesContentLabel,
                itemNames: widget.category.itemsBelong),
            ContentListWidget(
                backgroundColor: const Color.fromARGB(255, 235, 206, 206),
                title: Languages.of(context)!.wasteBinNoContentLabel,
                itemNames: widget.category.itemsDontBelong),
          ],
    );
  }
}
