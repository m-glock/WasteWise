import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/waste_bin/content_list_widget.dart';

import '../../../../../model_classes/waste_bin_category.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({Key? key, required this.category}) : super(key: key);

  final WasteBinCategory category;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: [
          ContentListWidget(
              backgroundColor: const Color.fromARGB(255, 216, 227, 204),
              title: Languages.of(context)!.wasteBinYesContentLabel,
              itemNames: category.itemsBelong),
          if(category.itemsDontBelong.isNotEmpty)
            ContentListWidget(
              backgroundColor: const Color.fromARGB(255, 235, 206, 206),
              title: Languages.of(context)!.wasteBinNoContentLabel,
              itemNames: category.itemsDontBelong),
        ],
      ),
    );
  }
}
