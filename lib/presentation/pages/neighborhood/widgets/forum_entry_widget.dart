import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';

import '../../../i18n/locale_constant.dart';
import '../../../util/constants.dart';
import '../../../util/database_classes/forum_entry_type.dart';
import '../../../util/database_classes/subcategory.dart';
import '../../../util/graphl_ql_queries.dart';
import '../../../util/time_duration.dart';

class ForumEntryWidget extends StatefulWidget {
  const ForumEntryWidget(
      {Key? key,
      required this.userName,
      this.userPictureUrl,
      required this.type,
      required this.createdAt,
      this.linkId,
      this.questionText})
      : super(key: key);

  final String userName;
  final String? userPictureUrl;
  final ForumEntryType type;
  final DateTime createdAt;
  final String? linkId;
  final String? questionText;

  @override
  State<ForumEntryWidget> createState() => _ForumEntryWidgetState();
}

class _ForumEntryWidgetState extends State<ForumEntryWidget> {
  double pictureSize = 30;
  String postContent = "";

  @override
  void initState() {
    super.initState();
    _getPostContent();
  }

  void _getPostContent() async {
    String forumEntryType = widget.type.typeName;
    String content = "";
    switch (forumEntryType) {
      case "Share":
        content = await _getTipName();
        break;
      case "Ally":
        content = await _getSubcategory();
        break;
      case "Question":
        content = "\n${widget.questionText}";
        break;
      default:
        throw Exception("Database error: entry type of forum post "
            "could not be detected.");
    }
    setState(() {
      postContent = content;
    });
  }

  Future<String> _getTipName() async {
    Locale locale = await getLocale();
    Map<String, dynamic> inputVariables = {
      "languageCode": locale.languageCode,
      "tipId": widget.linkId,
    };

    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult<Object?> result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(GraphQLQueries.getTipName),
        variables: inputVariables,
      ),
    );
    return "\"${result.data?["getTipName"]}\"";
  }

  Future<String> _getSubcategory() async {
    Subcategory subcategory = DataHolder.subcategoriesById[widget.linkId]!;
    return "\"${subcategory.title}\"";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Constants.tileBorderRadius,
      ),
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
              ),
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
          SizedBox(
            width: double.infinity,
            child: Text(
              widget.type.text.replaceFirst("\${}", postContent),
              textAlign: TextAlign.start,
            ),
          ),
          TextButton(onPressed: () => {}, child: Text(widget.type.buttonText)),
        ],
      ),
    );
  }
}
