import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../util/constants.dart';
import '../../util/tip.dart';

class TipDetailPage extends StatefulWidget {
  const TipDetailPage({Key? key, required this.tip}) : super(key: key);

  final Tip tip;

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
        title: Text(widget.tip.title),
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
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _changeBookmarkStatus(),
                  child: widget.tip.isBookmarked
                      ? const Icon(FontAwesomeIcons.bookmark)
                      : const Icon(FontAwesomeIcons.solidBookmark),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                GestureDetector(
                  onTap: () => {
                    //TODO: open modal to share with neighborhood
                  },
                  child: const Icon(FontAwesomeIcons.shareNodes),
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
