import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/util/custom_icon_button.dart';

import '../../i18n/languages.dart';
import '../../util/constants.dart';
import '../../util/database_classes/tip.dart';
import '../../util/graphl_ql_queries.dart';

class TipDetailPage extends StatefulWidget {
  const TipDetailPage(
      {Key? key,
      required this.tip,
      required this.tipNumber,
      required this.updateBookmarkInParent})
      : super(key: key);

  final Tip tip;
  final int tipNumber;
  final Function updateBookmarkInParent;

  @override
  State<TipDetailPage> createState() => _TipDetailPageState();
}

class _TipDetailPageState extends State<TipDetailPage> {

  ParseUser? currentUser;
  late Image _image;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _image = Image.network(widget.tip.imageUrl);
    _image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((image, synchronousCall) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }));
  }

  void _getCurrentUser() async {
    ParseUser? current = await ParseUser.currentUser();
    setState(() {
      currentUser = current;
    });
  }

  void _changeBookmarkStatus() async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    // remove or add the bookmark depending on the bookmark state
    bool success = widget.tip.isBookmarked
        ? await GraphQLQueries.removeTipBookmark(widget.tip.objectId, client)
        : await GraphQLQueries.addTipBookmark(widget.tip.objectId, client);

    // change bookmark status if DB entry was successful
    // or notify user if not
    if (success) {
      setState(() {
        widget.tip.isBookmarked = !widget.tip.isBookmarked;
        widget.updateBookmarkInParent();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Languages.of(context)!.bookmarkingFailedText),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tipp #${widget.tipNumber}"),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5)),
                      if (currentUser != null) ...[
                        widget.tip.isBookmarked
                            ? CustomIconButton(
                                onPressed: _changeBookmarkStatus,
                                icon:
                                    const Icon(FontAwesomeIcons.solidBookmark))
                            : CustomIconButton(
                                onPressed: _changeBookmarkStatus,
                                icon: const Icon(FontAwesomeIcons.bookmark),
                              ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5)),
                      ],
                      CustomIconButton(
                          onPressed: () => {},
                          //TODO: open modal to share with neighborhood
                          icon: const Icon(FontAwesomeIcons.shareNodes)),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  _image,
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  Text(widget.tip.explanation,
                      style: Theme.of(context).textTheme.bodyText1)
                ],
              ),
            ),
    );
  }
}
