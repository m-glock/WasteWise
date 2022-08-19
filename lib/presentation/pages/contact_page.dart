import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

import '../util/constants.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.contactPageName),
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.pagePadding),
        child: const Center(),
      ),
    );
  }
}
