import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

class AppPurposeIntroScreen extends StatefulWidget {
  const AppPurposeIntroScreen({Key? key}) : super(key: key);

  @override
  State<AppPurposeIntroScreen> createState() => _AppPurposeIntroScreenState();
}

class _AppPurposeIntroScreenState extends State<AppPurposeIntroScreen> {

  Widget _getQuestionText(String text){
    return Row(
      children: [
        const Icon(Icons.question_mark_rounded),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
        Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
                fontFamily: Theme.of(context).textTheme.bodyText2!.fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              _getQuestionText(Languages.of(context)!.purposeScreenQ1),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              _getQuestionText(Languages.of(context)!.purposeScreenQ2),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              _getQuestionText(Languages.of(context)!.purposeScreenQ3),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
        Text(
          Languages.of(context)!.purposeScreenExplanation,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}