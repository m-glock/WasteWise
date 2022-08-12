import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({Key? key}) : super(key: key);

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  String bulletPoint = "\u2022 ";

  //TODO add items with a ListViewBuilder and add items with the onPressed function
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 216, 227, 204),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.only(top: 25, left: 25, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Das gehört rein: ",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  "$bulletPoint item 1",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  "$bulletPoint item 1",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  "$bulletPoint item 1",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  "$bulletPoint item 1",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  "$bulletPoint item 1",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  "$bulletPoint item 1",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => {},
                    child: Row(
                      children: const [
                        Icon(FontAwesomeIcons.angleRight, size: 12),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text("Mehr"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 235, 206, 206),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.only(top: 25, left: 25, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Das gehört nicht rein: ",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  "$bulletPoint item 1",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  "$bulletPoint item 1",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  "$bulletPoint item 1",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  "$bulletPoint item 1",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  "$bulletPoint item 1",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  "$bulletPoint item 1",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => {},
                    child: Row(
                      children: const [
                        Icon(FontAwesomeIcons.angleRight, size: 12),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text("Mehr"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
