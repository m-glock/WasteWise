import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/util/collection_point.dart';

class CollectionPointDetailPage extends StatefulWidget {
  const CollectionPointDetailPage(
      {Key? key,
      required this.collectionPoint,
      required this.acceptedItems})
      : super(key: key);

  final CollectionPoint collectionPoint;
  final List<String> acceptedItems;

  @override
  State<CollectionPointDetailPage> createState() =>
      _CollectionPointDetailPageState();
}

class _CollectionPointDetailPageState extends State<CollectionPointDetailPage> {

  String bulletPoint = "\u2022 ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"), //TODO correct name of recycling yard
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 30, 20),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.location_on, size: 25),
                ),
                Text(widget.collectionPoint.address.toString()),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: const [
                        Icon(Icons.access_time, size: 25),
                      ],
                    ),
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          alignment: Alignment.centerLeft,
                          height: 25,
                          child: const Text("Aktuell geöffnet"), //TODO correct text
                        ),
                        /*...widget.openingHours.entries.map((entry) {
                          return Padding(padding: EdgeInsets.only(bottom: 5), child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(entry.key),
                              Expanded(
                                child: Text(entry.value, textAlign: TextAlign.end),
                              ),
                            ],
                          ),);
                        }).toList()*/
                      ],
                    ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: const [
                      Icon(Icons.adb, size: 25), //TODO
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        alignment: Alignment.centerLeft,
                        height: 25,
                        child: const Text("Annahme von"), //TODO correct text
                      ),
                      ...widget.acceptedItems.map((item){
                        return Padding(padding: EdgeInsets.only(bottom: 5), child: Text("$bulletPoint $item"));
                      }).toList()
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
