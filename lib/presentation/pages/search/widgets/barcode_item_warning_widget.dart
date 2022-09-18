import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

class BarcodeItemWarningWidget extends StatefulWidget {
  const BarcodeItemWarningWidget({
    Key? key, required this.errorText
  }) : super(key: key);

  final String errorText;

  @override
  State<BarcodeItemWarningWidget> createState() =>
      _BarcodeItemWarningWidgetState();
}

class _BarcodeItemWarningWidgetState extends State<BarcodeItemWarningWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Theme.of(context).colorScheme.error,
      width: double.infinity,
      child: Column(
        children: [
          Text(
            Languages.of(context)!.itemDetailBarcodeWarningTitle.toUpperCase(),
            style: TextStyle(
                color: Theme.of(context).colorScheme.onError,
                fontWeight: FontWeight.bold,
                fontSize: Theme.of(context).textTheme.headline3!.fontSize),
            textAlign: TextAlign.center,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Text(
            widget.errorText,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onError,
                fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
                fontWeight: Theme.of(context).textTheme.bodyText1!.fontWeight),
          )
        ],
      ),
    );
  }
}
