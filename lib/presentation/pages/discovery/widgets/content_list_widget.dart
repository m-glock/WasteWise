import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContentListWidget extends StatefulWidget {
  const ContentListWidget(
      {Key? key,
      required this.backgroundColor,
      required this.showMore,
      required this.title,
      required this.itemNames})
      : super(key: key);

  final Color backgroundColor;
  final Function showMore;
  final String title;
  final List<String> itemNames;

  @override
  State<ContentListWidget> createState() => _ContentListWidgetState();
}

class _ContentListWidgetState extends State<ContentListWidget> {
  String bulletPoint = "\u2022 ";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.only(top: 25, left: 25, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          ...widget.itemNames.map(
            (name) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(
                "$bulletPoint $name",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => {},
                child: Row(
                  children: const [
                    Icon(FontAwesomeIcons.angleRight, size: 12),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text("Mehr"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
