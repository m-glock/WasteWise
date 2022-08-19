import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../util/constants.dart';

class TipTile extends StatefulWidget {
  const TipTile(
      {Key? key,
      required this.title,
      required this.destinationPage,
      required this.bookmarked})
      : super(key: key);

  final String title;
  final Widget destinationPage;
  final bool bookmarked;

  @override
  State<TipTile> createState() => _TipTileState();
}

class _TipTileState extends State<TipTile> {
  List<String> tags = ["Vermeidung", "Biotonne"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.destinationPage),
        );
      },
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: Constants.tileBorderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              widget.bookmarked
                  ? const Icon(Icons.bookmark_border_outlined)
                  : const Icon(Icons.bookmark),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 5)),
                      Row(children: [
                        ...tags.map((tagName) => Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              margin: const EdgeInsets.only(right: 5),
                              child: Text(
                                tagName,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            )),
                      ])
                    ],
                  ),
                ),
              ),
              const Icon(FontAwesomeIcons.angleRight),
            ],
          ),
        ),
      ),
    );
  }
}
