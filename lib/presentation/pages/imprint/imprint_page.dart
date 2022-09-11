import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

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
        child: Center(
          child: Column(
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
          ),
        ),
      ),
    );
  }
}