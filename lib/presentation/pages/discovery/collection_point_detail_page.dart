import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

import '../../../model_classes/collection_point.dart';

class CollectionPointDetailPage extends StatefulWidget {
  const CollectionPointDetailPage({Key? key, required this.collectionPoint})
      : super(key: key);

  final CollectionPoint collectionPoint;

  @override
  State<CollectionPointDetailPage> createState() =>
      _CollectionPointDetailPageState();
}

class _CollectionPointDetailPageState extends State<CollectionPointDetailPage> {
  String bulletPoint = "\u2022 ";
  int range = 5;


  List<Widget> _getFormattedOpeningHours() {
    List<String> openingHours = widget.collectionPoint.openingHours.split("|");
    List<String> weekdays = Languages.of(context)!.weekdays;
    List<Widget> openingHoursWithDay = [];

    for (int i = 0; i < weekdays.length; i++) {
      String openingHoursOnDay = openingHours.elementAt(i);
      openingHoursWithDay.add(Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(weekdays.elementAt(i)),
            Expanded(
              child: Text(
                  openingHoursOnDay != "closed"
                      ? openingHoursOnDay
                      : Languages.of(context)!.cpOpeningHoursClosed,
                  textAlign: TextAlign.end),
            ),
          ],
        ),
      ));
    }
    return openingHoursWithDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.collectionPoint.collectionPointType.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 30, 20),
          child: Column(
            children: [
              if (widget.collectionPoint.withHazardousMaterials)
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withAlpha(50),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                      Text(Languages.of(context)!.cpWithHazardousMaterial),
                    ],
                  ),
                ),
              if (widget.collectionPoint.withSecondHand)
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withAlpha(50),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                      Expanded(
                        child: Text(Languages.of(context)!.cpWithSecondHand),
                      ),
                    ],
                  ),
                ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.location_on, size: 25),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.centerLeft,
                          height: 25,
                          child: Text(
                            Languages.of(context)!.copDetailsAddressTitle,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        Text(widget.collectionPoint.address.toString()),
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
                        Icon(FontAwesomeIcons.clock, size: 25),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.centerLeft,
                          height: 25,
                          child: Text(
                            Languages.of(context)!.cpDetailsOpeningHours,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        ..._getFormattedOpeningHours(),
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
                        Icon(Icons.assignment_turned_in_outlined, size: 25),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.centerLeft,
                          height: 25,
                          child: Text(
                            Languages.of(context)!.cpDetailItemsAccepted,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        ...widget.collectionPoint.acceptedSubcategories.getRange(0, range)
                            .map((item) {
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text("$bulletPoint ${item.title}"));
                        }).toList(),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Text(range < widget.collectionPoint.acceptedSubcategories.length
                                  ? Languages.of(context)!.wasteBinShowMoreLabel
                                  : Languages.of(context)!.wasteBinShowLessLabel,
                              ),
                              onPressed: () => setState(() {
                                range = range == widget.collectionPoint.acceptedSubcategories.length
                                    ? 5
                                    : widget.collectionPoint.acceptedSubcategories.length;
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
