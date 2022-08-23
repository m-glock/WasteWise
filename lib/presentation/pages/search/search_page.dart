import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/pages/search/barcode_scan_page.dart';
import 'package:recycling_app/presentation/pages/search/widgets/search_bar.dart';

import '../../i18n/languages.dart';
import '../../i18n/locale_constant.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> recentlySearched = ["Styropor", "Asche", "Holz"];
  List<String> oftenSearched = ["Korken", "Kleiderbügel", "Knochen"];

  String languageCode = "";
  String query = """
    query GetItemNames(\$languageCode: String!){
      getItemNames(languageCode: \$languageCode){
        title
        synonyms
        item_id{
          objectId
        }
      }
    }
  """;

  @override
  void initState() {
    super.initState();
    _getLanguageCode();
  }

  void _getLanguageCode() async {
    Locale locale = await getLocale();
    setState(() {
      languageCode = locale.languageCode;
    });
  }

  Widget _barcodeScannerButton() {
    return SizedBox(
      width: 160,
      child: ElevatedButton(
        child: Row(
          children: const [
            Icon(FontAwesomeIcons.barcode, size: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('Barcode Scanner'),
            )
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BarcodeScanPage()),
          );
        },
      ),
    );
  }

  List<Widget> _itemList(List<String> listOfNames) {
    return listOfNames
        .map((element) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child:
                  Text(element, style: Theme.of(context).textTheme.bodyText1),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
        options: QueryOptions(
            document: gql(query), variables: {"languageCode": languageCode}),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) return Text(result.exception.toString());
          if (result.isLoading) return const Center(child: CircularProgressIndicator());

          List<dynamic> items = result.data?["getItemNames"];

          if (items.isEmpty) {
            return const Text("No tips found.");
          }

          Map<String, String> itemNames = {};
          for (dynamic element in items) {
            //TODO: entry for each synonym?
            itemNames[element["title"]] = element["item_id"]["objectId"];
          }

          // display when all data is available
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBar(itemNames: itemNames),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 40),
                  child: _barcodeScannerButton(),
                ),
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //TODO replace with actual items and links
                        Text(Languages.of(context)!.recentlySearched,
                            style: Theme.of(context).textTheme.headline3),
                        const Padding(padding: EdgeInsets.only(bottom: 15)),
                        ..._itemList(recentlySearched),
                        const Padding(padding: EdgeInsets.only(bottom: 25)),
                        Text(Languages.of(context)!.oftenSearched,
                            style: Theme.of(context).textTheme.headline3),
                        const Padding(padding: EdgeInsets.only(bottom: 15)),
                        ..._itemList(oftenSearched),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
