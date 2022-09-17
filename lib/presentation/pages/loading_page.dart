import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../i18n/locale_constant.dart';
import '../util/constants.dart';
import '../util/data_holder.dart';
import '../util/graphl_ql_queries.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  File? _dataFile;
  String? languageCode;
  String? municipalityId;

  @override
  void initState() {
    super.initState();
    _checkIfSavedDataExists();
  }

  void _checkIfSavedDataExists() async {
    Directory dir = await getApplicationDocumentsDirectory();
    _dataFile = File('${dir.path}/subcategories.json');

    if(_dataFile!.existsSync()) {
      await DataHolder.readDataFromFile(_dataFile!);
    } else {
      await _getDataFromServer();
    }

    Route route = MaterialPageRoute(builder: (context) => const HomePage());
    Navigator.pushReplacement(context, route);
  }

  Future<void> _getDataFromServer() async {
    Locale locale = await getLocale();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? id = _prefs.getString(Constants.prefSelectedMunicipalityCode);

    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult result = await client.query(
      QueryOptions(
          document: gql(GraphQLQueries.initialQuery),
          variables: {
            "languageCode": locale.languageCode,
            "municipalityId": id ??  "",
          }),
    );
    await GraphQLQueries.initialDataExtraction(result.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: Constants.pagePadding, horizontal: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //TODO: add logo or image
              Text(
                Languages.of(context)!.waitingForInitializationText,
                style: Theme.of(context).textTheme.headline1,
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}