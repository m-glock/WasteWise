import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/util/database_classes/forum_entry.dart';
import 'package:recycling_app/presentation/util/database_classes/forum_entry_type.dart';
import 'package:recycling_app/presentation/util/database_classes/zip_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../i18n/languages.dart';
import '../../../util/constants.dart';
import '../../../util/custom_icon_button.dart';
import '../../../util/data_holder.dart';
import '../../../util/graphl_ql_queries.dart';
import '../../../util/lat_lng_distance.dart';
import 'forum_entry_widget.dart';

class NeighborhoodFeedWidget extends StatefulWidget {
  const NeighborhoodFeedWidget({Key? key}) : super(key: key);

  @override
  State<NeighborhoodFeedWidget> createState() => _NeighborhoodFeedWidgetState();
}

class _NeighborhoodFeedWidgetState extends State<NeighborhoodFeedWidget> {
  final TextEditingController controller = TextEditingController();
  List<ForumEntryWidget> forumEntries = [];
  Map<ForumEntryType, bool> forumEntryTypesSelected = {};
  String? municipalityId;
  List<String>? zipCodes;

  @override
  void initState() {
    super.initState();
    _setFilter();
    _setNearbyZipCodes();
    _setMunicipality();
  }

  void _setFilter(){
    for (ForumEntryType element in DataHolder.forumEntryTypesById.values) {
      forumEntryTypesSelected[element] = false;
    }
  }

  void _setNearbyZipCodes() async {
    ParseUser current = await ParseUser.currentUser();
    dynamic zipCodeId = current.get("zip_code_id").get("objectId");
    ZipCode userZipCode = DataHolder.zipCodesById[zipCodeId]!;
    List<String> nearbyZipCodes = getNearbyZipCodes(
            DataHolder.zipCodesById.values.toList(), userZipCode.latLng)
        .map((zipCode) => zipCode.zipCode)
        .toList();
    setState(() {
      zipCodes = nearbyZipCodes;
    });
  }

  void _setMunicipality() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? currentMunicipalityId =
        _prefs.getString(Constants.prefSelectedMunicipalityCode);
    setState(() {
      municipalityId = currentMunicipalityId;
    });
  }

  void _createForumPost() async {
    String forumTypeId = DataHolder.forumEntryTypesById.entries
        .firstWhere((element) => element.value.typeName == "Question")
        .key;
    Map<String, dynamic> inputVariables = {
      "userId": (await ParseUser.currentUser())?.objectId,
      "forumEntryTypeId": forumTypeId,
      "text": controller.text,
    };

    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult<Object?> result = await client.query(
      QueryOptions(
        document: gql(GraphQLQueries.createForumPost),
        variables: inputVariables,
      ),
    );

    Map<String, dynamic>? forumEntryData = result.data?["createForumEntries"];

    String snackBarText = result.hasException || forumEntryData == null
        ? Languages.of(context)!.cpPostUnsuccessfulText
        : Languages.of(context)!.cpPostSuccessfulText;

    FocusManager.instance.primaryFocus?.unfocus();

    if (forumEntryData != null) {
      ForumEntry forumEntry = ForumEntry.fromGraphQLData(forumEntryData);
      setState(() {
        forumEntries.insert(0, ForumEntryWidget(
            key: ValueKey(forumEntry.objectId),
            forumEntry: forumEntry
        ));
      });
    }

    setState(() {
      controller.text = "";
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(snackBarText)));
  }

  Widget _getWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Languages.of(context)!.filterByText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...forumEntryTypesSelected.entries.map((entry) {
              return Row(
                children: [
                  Checkbox(
                    value: entry.value,
                    onChanged: (bool? checked) {
                      setState(() {
                        forumEntryTypesSelected[entry.key] = checked!;
                      });
                    },
                  ),
                  Text(entry.key.title),
                ],
              );
            }),
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        Container(
          color: Theme.of(context).colorScheme.surface,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autocorrect: false,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.surface,
                    labelText: Languages.of(context)!.askQuestionHintText,
                    filled: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
              CustomIconButton(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                icon: const Icon(Icons.send),
                onPressed: () => _createForumPost(),
              ),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: forumEntries.length,
            itemBuilder: (BuildContext context, int index) {
              return forumEntries[index];
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return forumEntries.isNotEmpty
        ? _getWidget()
        : municipalityId == null || zipCodes == null
            ? const Center(child: CircularProgressIndicator())
            : Query(
                options: QueryOptions(
                  fetchPolicy: FetchPolicy.networkOnly,
                  document: gql(GraphQLQueries.getForumEntries),
                  variables: {
                    "municipalityId": municipalityId,
                    "zipCodes": zipCodes,
                  },
                ),
                builder: (QueryResult result,
                    {VoidCallback? refetch, FetchMore? fetchMore}) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }
                  if (result.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List<dynamic> forumEntryData =
                      result.data?["getForumEntries"];
                  for (dynamic element in forumEntryData) {
                    ForumEntry entry = ForumEntry.fromGraphQLData(element);
                    forumEntries.add(ForumEntryWidget(
                        key: ValueKey(entry.objectId),
                        forumEntry: entry
                    ));
                  }

                  return _getWidget();
                },
              );
  }
}
