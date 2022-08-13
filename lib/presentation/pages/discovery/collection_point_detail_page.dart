import 'package:flutter/material.dart';

class CollectionPointDetailPage extends StatefulWidget {
  const CollectionPointDetailPage(
      {Key? key,
      required this.address,
      required this.openingHours,
      required this.acceptedItems})
      : super(key: key);

  final String address;
  final Map<String, String> openingHours;
  final String acceptedItems;

  @override
  State<CollectionPointDetailPage> createState() =>
      _CollectionPointDetailPageState();
}

class _CollectionPointDetailPageState extends State<CollectionPointDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.location_on, size: 25),
                ),
                Text(widget.address),
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
                          //color: Colors.lightGreen,
                          alignment: Alignment.centerLeft,
                          height: 25,
                          child: const Text("Aktuell geöffnet"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text("Example"),
                            Expanded(
                              child: Text("12-17 Uhr", textAlign: TextAlign.end),
                            ),
                          ],
                        ),
                      ],
                    ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.adb), //TODO
                ),
                const Text("Annahme von:"),
                Text(widget.acceptedItems),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
