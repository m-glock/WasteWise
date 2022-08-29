import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

class AppPurposeIntroScreen extends StatefulWidget {
  const AppPurposeIntroScreen({Key? key}) : super(key: key);

  @override
  State<AppPurposeIntroScreen> createState() => _AppPurposeIntroScreenState();
}

class _AppPurposeIntroScreenState extends State<AppPurposeIntroScreen> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(Languages.of(context)!.purposeScreenExplanation),
      ],
    );
  }
}