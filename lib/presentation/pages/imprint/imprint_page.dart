import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

import '../../icons/custom_icons.dart';

class ImprintPage extends StatefulWidget {
  const ImprintPage({Key? key}) : super(key: key);

  @override
  State<ImprintPage> createState() => _ImprintPageState();
}

class _ImprintPageState extends State<ImprintPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.imprintPageName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      Languages.of(context)!.imprintParagraphTitle,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    Text(
                      "Mareike Glock",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                    Text(
                      "Trojanstr. 2",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                    Text(
                      "12437 Berlin",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                    Text(
                      Languages.of(context)!.contactPageName,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    Text(
                      "mareike.gl@googlemail.com",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 30)),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Languages.of(context)!.legalNotes,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Text(
                      Languages.of(context)!.liabilityTitle,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    Text(
                      Languages.of(context)!.liabilityText,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Text(
                      Languages.of(context)!.iconsTitle,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    Row(
                      children: [
                        const Icon(
                          CustomIcons.lightbulb,
                          size: 35,
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5)),
                        Expanded(
                          child: Text(
                            "Created by Numero Uno from Noun Project",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    Row(
                      children: [
                        const Icon(
                          CustomIcons.map,
                          size: 35,
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5)),
                        Expanded(
                          child: Text(
                            "Created by ABDUL LATIF from Noun Project",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    Row(
                      children: [
                        const Icon(
                          CustomIcons.garbageCan,
                          size: 35,
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5)),
                        Expanded(
                          child: Text(
                            "Created by Eko Pumomo from Noun Project",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
