import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../util/constants.dart';
import '../../../util/time_duration.dart';

class ForumEntryWidget extends StatefulWidget {
  const ForumEntryWidget(
      {Key? key,
      required this.userName,
      required this.userPictureUrl,
      required this.forumText,
      required this.buttonText,
      required this.createdAt})
      : super(key: key);

  final String userName;
  final String? userPictureUrl;
  final String forumText;
  final String buttonText;
  final DateTime createdAt;

  @override
  State<ForumEntryWidget> createState() => _ForumEntryWidgetState();
}

class _ForumEntryWidgetState extends State<ForumEntryWidget> {
  double pictureSize = 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Constants.tileBorderRadius,
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(pictureSize),
                child: widget.userPictureUrl != null
                    ? CachedNetworkImage(
                        imageUrl: widget.userPictureUrl!,
                        width: pictureSize,
                        height: pictureSize,
                      )
                    : Container(
                        color: Colors.black12,
                        width: pictureSize,
                        height: pictureSize,
                        child: const Icon(
                          FontAwesomeIcons.user,
                          size: 10,
                        ),
                      ),
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 5),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    getTimeframe(widget.createdAt),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              )
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Center(
            child: Text(widget.forumText),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          OutlinedButton(onPressed: () => {}, child: Text(widget.buttonText)),
        ],
      ),
    );
  }
}
