import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../i18n/locale_constant.dart';
import '../../util/item.dart';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage(
      {Key? key, required this.itemName, required this.objectId})
      : super(key: key);

  final String itemName;
  final String objectId;

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

//TODO: figure out how to access category name (TL)
class _ItemDetailPageState extends State<ItemDetailPage> {
  String languageCode = "";
  String query = """
    query GetItem(\$languageCode: String!, \$objectId: String!){
      getItem(languageCode: \$languageCode, objectId: \$objectId){
        title
        explanation
        material
        item_id{
          subcategory_id{
            category_id{
        	    hex_color
        	    image_file{
                url
              }  
      	    }
          }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemName),
      ),
      body: Query(
        options: QueryOptions(
            //TODO: check if still necessary after figuring cache out
            fetchPolicy: FetchPolicy.networkOnly,
            document: gql(query),
            variables: {
              "languageCode": languageCode,
              "objectId": widget.objectId,
            }),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) return Text(result.exception.toString());
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          List<dynamic> items = result.data?["getItem"];

          if (items.isEmpty) {
            Navigator.pop(context);
            //TODO: let user know whats wrong
            return const Text("No tips found.");
          }

          Item item = Item(items[0]["title"], items[0]["explanation"],
              items[0]["material"], null);

          // display when all data is available
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image(image: image),
              Container(
                width: 100,
                height: 80,
                color: Colors.black12,
              ),
              Text("Material: ${item.material}"),
              const Text("Tonne: Wertstofftonne"),
              const Text("Mehr info zu Verpackungsmüll")
            ],
          );
        },
      ),
    );
  }
}
