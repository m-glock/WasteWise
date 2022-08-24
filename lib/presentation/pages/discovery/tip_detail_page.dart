import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycling_app/presentation/util/custom_icon_button.dart';

import '../../util/constants.dart';
import '../../util/database_classes/tip.dart';

class TipDetailPage extends StatefulWidget {
  const TipDetailPage({
    Key? key,
    required this.tip,
    required this.tipNumber
  }) : super(key: key);

  final Tip tip;
  final int tipNumber;

  @override
  State<TipDetailPage> createState() => _TipDetailPageState();
}

class _TipDetailPageState extends State<TipDetailPage> {
  void _changeBookmarkStatus() {
    //TODO: update in DB
    setState(() {
      widget.tip.isBookmarked = !widget.tip.isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tipp #${widget.tipNumber}"),
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.pagePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(widget.tip.title,
                      style: Theme.of(context).textTheme.headline1),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                widget.tip.isBookmarked
                      ? CustomIconButton(
                          onPressed: _changeBookmarkStatus,
                          icon: const Icon(FontAwesomeIcons.bookmark),
                        )
                      : CustomIconButton(
                          onPressed: _changeBookmarkStatus,
                          icon: const Icon(FontAwesomeIcons.solidBookmark)
                        ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                CustomIconButton(
                    onPressed: () => {}, //TODO: open modal to share with neighborhood
                    icon: const Icon(FontAwesomeIcons.shareNodes)
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 30)),
            Image.network(widget.tip.imageUrl),
            const Padding(padding: EdgeInsets.only(bottom: 30)),
            Text(widget.tip.explanation,
                style: Theme.of(context).textTheme.bodyText1)
          ],
        ),
      ),
    );
  }
}
