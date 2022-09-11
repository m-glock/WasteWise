import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/contact/widgets/contact_form_widget.dart';
import 'package:recycling_app/presentation/pages/contact/widgets/imprint_widget.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: const [
              ContactFormWidget(),
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              ImprintWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
