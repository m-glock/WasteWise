import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

class ContactFormWidget extends StatefulWidget {
  const ContactFormWidget({Key? key}) : super(key: key);

  @override
  State<ContactFormWidget> createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          Text(
            Languages.of(context)!.contactPageIntroText,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              hintText: Languages.of(context)!.contactPageNameHintText,
              border: InputBorder.none,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return Languages.of(context)!.contactPageValidationText;
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              hintText: Languages.of(context)!.contactPageEmailHintText,
              border: InputBorder.none,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return Languages.of(context)!.contactPageValidationText;
              } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
                return Languages.of(context)!.contactPageEmailValidationText;
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 8,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              hintText: Languages.of(context)!.contactPageContentHintText,
              border: InputBorder.none,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return Languages.of(context)!.contactPageValidationText;
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                //TODO: send info
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: Text(Languages.of(context)!.contactPageSubmitButtonText),
          ),
        ],
      ),
    );
  }
}
