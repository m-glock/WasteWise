import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

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
      body: const Center(),
    );
  }
}