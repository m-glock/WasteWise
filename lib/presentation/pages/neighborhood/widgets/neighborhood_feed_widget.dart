import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/util/database_classes/forum_entry_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../util/constants.dart';
import '../../../util/data_holder.dart';
import '../../../util/graphl_ql_queries.dart';
import 'forum_entry_widget.dart';

class NeighborhoodFeedWidget extends StatefulWidget {
  const NeighborhoodFeedWidget({Key? key}) : super(key: key);

  @override
  State<NeighborhoodFeedWidget> createState() => _NeighborhoodFeedWidgetState();
}

class _NeighborhoodFeedWidgetState extends State<NeighborhoodFeedWidget> {
  String? municipalityId;

  @override
  void initState() {
    super.initState();
    _setMunicipality();
  }

  void _setMunicipality() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? currentMunicipalityId =
        _prefs.getString(Constants.prefSelectedMunicipalityCode);
    setState(() {
      municipalityId = currentMunicipalityId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return municipalityId == null
        ? const Center(child: CircularProgressIndicator())
        : Query(
            options: QueryOptions(
                document: gql(GraphQLQueries.getForumEntries),
                variables: {"municipalityId": municipalityId}),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }
              if (result.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              List<dynamic> forumEntries = result.data?["getForumEntries"];

              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: forumEntries.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> entry = forumEntries[index];
                    ForumEntryType type = DataHolder.forumEntryTypesById[
                        entry["forum_entry_type_id"]["objectId"]]!;
                    return ForumEntryWidget(
                      userName: entry["user_id"]["username"],
                      userPictureUrl: entry["user_id"]["avatar_picture"]
                          ?["url"],
                      type: type,
                      createdAt: DateTime.parse(entry["createdAt"]),
                      linkId: entry["link_id"],
                      questionText: entry["question_text"],
                    );
                  },
                ),
              );
            },
    );
  }
}
