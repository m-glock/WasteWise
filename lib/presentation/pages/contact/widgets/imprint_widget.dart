import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

class ImprintWidget extends StatefulWidget {
  const ImprintWidget({Key? key}) : super(key: key);

  @override
  State<ImprintWidget> createState() => _ImprintWidgetState();
}

class _ImprintWidgetState extends State<ImprintWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Languages.of(context)!.contactPageImprintParagraphTitle,
          style: Theme.of(context).textTheme.headline1,
        ),
        Text("Mareike Glock", style: Theme.of(context).textTheme.bodyText1,),
        Text("Trojanstr. 2", style: Theme.of(context).textTheme.bodyText1,),
        Text("12437 Berlin", style: Theme.of(context).textTheme.bodyText1,),
        const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        Text(
          Languages.of(context)!.contactPageName,
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          "mareike.gl@googlemail.com",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
