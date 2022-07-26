import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/logic/database_access/queries/dashboard_queries.dart';
import 'package:recycling_app/logic/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../logic/services/data_service.dart';
import '../../../../logic/util/user.dart';
import '../../../../model_classes/zip_code.dart';
import '../../../i18n/languages.dart';
import '../../../../logic/util/lat_lng_distance.dart';

class TextTile extends StatefulWidget {
  const TextTile({Key? key}) : super(key: key);

  @override
  State<TextTile> createState() => _TextTileState();
}

class _TextTileState extends State<TextTile> {
  String? municipalityId;
  List<String> zipCodes = [];

  void _getValues(ParseUser current) async {
    // get municipality id
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? id = _prefs.getString(Constants.prefSelectedMunicipalityCode);

    // get zip codes
    String? zipCodeId = current.get("zip_code_id")?.get("objectId");
    List<String> nearbyZipCodes = [];
    if (zipCodeId != null) {
      DataService dataService = Provider.of<DataService>(context, listen: false);
      ZipCode userZipCode = dataService.zipCodesById[zipCodeId]!;
      nearbyZipCodes = getNearbyZipCodes(
              dataService.zipCodesById.values.toList(), userZipCode.latLng)
          .map((zipCode) => zipCode.zipCode)
          .toList();
    }

    // update variables
    setState(() {
      municipalityId = id;
      zipCodes.addAll(nearbyZipCodes);
    });
  }

  Widget _getWidget({double? percentage}) {
    return Flexible(
      child: Column(
        children: [
          Center(
            child: Text(
              percentage == null
                  ? Languages.of(context)!.congratsTileDefaultTitle
                  : Languages.of(context)!.congratsTileTitle,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          percentage == null
              ? Text(Languages.of(context)!.congratsTileDefaultText)
              : Text.rich(
                  TextSpan(
                    text: Languages.of(context)!.congratsTileFirstFragment,
                    style: Theme.of(context).textTheme.bodyText2,
                    children: <TextSpan>[
                      TextSpan(
                        text: "${((percentage / 10).round() * 10).toString()}%",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(
                          text:
                              Languages.of(context)!.congratsTileSecondFragment,
                          style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(builder: (BuildContext context, User user, child) {
      if(user.currentUser == null){
         return _getWidget();
      } else if (municipalityId == null) {
        _getValues(user.currentUser!);
        return const Center(child: CircularProgressIndicator());
      } else {
        return Query(
          options: QueryOptions(
            document: gql(DashboardQueries.compareInNeighborhoodQuery),
            variables: {
              "userId": user.currentUser!.objectId,
              "municipalityId": municipalityId,
              "zipCodes": zipCodes
            },
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return const Center();
            }

            num? percentage = result.data?["compareInNeighborhood"];

            // display when all data is available
            return _getWidget(percentage: percentage?.toDouble());
          },
        );
      }
    });
  }
}
