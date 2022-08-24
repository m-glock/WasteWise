import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/waste_bin/myth_detail_widget.dart';
import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';

class MythWidget extends StatefulWidget {
  const MythWidget({Key? key, required this.category}) : super(key: key);

  final WasteBinCategory category;

  @override
  State<MythWidget> createState() => _MythWidgetState();
}

class _MythWidgetState extends State<MythWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: const EdgeInsets.only(top: 15),
          child: ListView(
            children: [
              ...widget.category.myths.map((myth) {
                return MythDetailWidget(myth: myth);
              })
            ],
          ),
    );
  }
}
