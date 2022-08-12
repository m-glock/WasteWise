import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/content_list_widget.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({Key? key}) : super(key: key);

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  List<String> itemNamesYes = [
    "item 1",
    "item 2",
    "item 3",
    "item 4",
    "item 5"
  ];
  List<String> itemNamesNo = [
    "item 6",
    "item 7",
    "item 8",
    "item 9",
    "item 10"
  ];

  //TODO add items with a ListViewBuilder and add items with the onPressed function
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContentListWidget(
            backgroundColor: const Color.fromARGB(255, 216, 227, 204),
            showMore: () => {},
            title: "Das gehört rein: ",
            itemNames: itemNamesYes),
        ContentListWidget(
            backgroundColor: const Color.fromARGB(255, 235, 206, 206),
            showMore: () => {},
            title: "Das gehört nicht rein: ",
            itemNames: itemNamesNo),
      ],
    );
  }
}
