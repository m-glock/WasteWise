import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/pages/discovery/tip_detail_page.dart';
import 'package:recycling_app/presentation/pages/neighborhood/thread_page.dart';
import 'package:recycling_app/logic/data_holder.dart';

import '../../../../model_classes/forum_entry.dart';
import '../../../../model_classes/tip.dart';
import '../../../i18n/locale_constant.dart';
import '../../../../logic/util/constants.dart';
import '../../../../model_classes/subcategory.dart';
import '../../../../logic/database_access/graphl_ql_queries.dart';
import '../../../../logic/util/time_duration.dart';
import '../../../icons/custom_icons.dart';

class ForumEntryWidget extends StatefulWidget {
  const ForumEntryWidget(
      {Key? key, required this.forumEntry, this.isRootEntry = true})
      : super(key: key);

  final ForumEntry forumEntry;
  final bool isRootEntry;

  @override
  State<ForumEntryWidget> createState() => _ForumEntryWidgetState();
}

class _ForumEntryWidgetState extends State<ForumEntryWidget> {
  double pictureSize = 30;
  String postContent = "";
  Tip? tip;

  @override
  void initState() {
    super.initState();
    _getPostContent();
  }

  void _getPostContent() async {
    String forumEntryType = widget.forumEntry.type.typeName;
    String content = "";
    switch (forumEntryType) {
      case "Share":
        tip = await _getTip();
        content = "\"${tip!.title}\"";
        break;
      case "Ally":
        content = await _getSubcategory();
        break;
      case "Question":
        content = "\n${widget.forumEntry.questionText}";
        break;
      case "Progress":
        content = "${widget.forumEntry.questionText}";
        break;
      default:
        throw Exception("Database error: entry type of forum post "
            "could not be detected.");
    }
    setState(() {
      postContent = content;
    });
  }

  Future<String> _getSubcategory() async {
    Subcategory subcategory =
        DataHolder.subcategoriesById[widget.forumEntry.linkId]!;
    return "\"${subcategory.title}\"";
  }

  void _buttonPressed() {
    switch (widget.forumEntry.type.typeName) {
      case "Share":
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TipDetailPage(tip: tip!)),
        );
        break;
      case "Ally":
      case "Question":
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ThreadPage(parentForumEntry: widget.forumEntry,)),
        );
        break;
      default:
        throw Exception("Database error: entry type of forum post "
            "could not be detected.");
    }
  }

  Future<Tip> _getTip() async {
    Locale locale = await getLocale();
    Map<String, dynamic> inputVariables = {
      "languageCode": locale.languageCode,
      "tipId": widget.forumEntry.linkId,
    };

    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult<Object?> result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(GraphQLQueries.tipDetailQuery),
        variables: inputVariables,
      ),
    );
    return Tip.fromGraphQlData(result.data?["getTip"]);
  }

  Widget _getIcon(){
    switch(widget.forumEntry.type.typeName){
      case "Share":
        return const Icon(CustomIcons.lightbulb);
      case "Ally":
        return const Icon(Icons.group);
      case "Question":
        return const Icon(Icons.question_answer_rounded);
      case "Progress":
        return const Icon(Icons.celebration_rounded);
      default:
        throw Exception("Database error: entry type of forum post "
            "could not be detected.");
    }
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(pictureSize),
                    child: widget.forumEntry.userPictureUrl != null
                        ? CachedNetworkImage(
                      imageUrl: widget.forumEntry.userPictureUrl!,
                      fit: BoxFit.fill,
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
                        widget.forumEntry.userName,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        getTimeframe(widget.forumEntry.createdAt),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ],
              ),
              if(widget.isRootEntry) _getIcon(),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          SizedBox(
            width: double.infinity,
            child: Text(
              widget.forumEntry.type.text.replaceFirst("\${}", postContent),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          widget.isRootEntry && widget.forumEntry.type.buttonText != null
              ? TextButton(
                  onPressed: () => _buttonPressed(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(widget.forumEntry.type.buttonText!),
                      ),
                      const Icon(FontAwesomeIcons.angleRight, size: 12),
                    ],
                  ),
                )
              : const Padding(padding: EdgeInsets.only(bottom: 30)),
        ],
      ),
    );
  }
}
