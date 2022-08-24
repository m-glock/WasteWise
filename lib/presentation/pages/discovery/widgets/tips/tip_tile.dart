import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycling_app/presentation/pages/discovery/tip_detail_page.dart';

import '../../../../util/constants.dart';
import '../../../../util/custom_icon_button.dart';
import '../../../../util/database_classes/tip.dart';

class TipTile extends StatefulWidget {
  const TipTile({
    Key? key,
    required this.tip,
    required this.tipNumber,
    required this.tags,
  }) : super(key: key);

  final Tip tip;
  final int tipNumber;
  final List<String> tags;

  @override
  State<TipTile> createState() => _TipTileState();
}

class _TipTileState extends State<TipTile> {
  void _bookmarkTip() {
    //TODO: update in DB
    setState(() {
      widget.tip.isBookmarked = !widget.tip.isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            widget.tip.isBookmarked
                ? CustomIconButton(
                    onPressed: _bookmarkTip,
                    icon: const Icon(Icons.bookmark),
                  )
                : CustomIconButton(
                    onPressed: _bookmarkTip,
                    icon: const Icon(Icons.bookmark_border_outlined),
                  ),
            const Padding(padding: EdgeInsets.only(right: 15)),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TipDetailPage(tip: widget.tip, tipNumber: widget.tipNumber,)),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.tip.title,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 5)),
                          Row(children: [
                            ...widget.tags.map((tagName) => Container(
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
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                )),
                          ])
                        ],
                      ),
                    ),
                    const Icon(FontAwesomeIcons.angleRight),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
