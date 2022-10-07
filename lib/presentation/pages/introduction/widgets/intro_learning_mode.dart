import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/logic/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearnModeIntroScreen extends StatefulWidget {
  const LearnModeIntroScreen({Key? key}) : super(key: key);

  @override
  State<LearnModeIntroScreen> createState() => _LearnModeIntroScreenState();
}

class _LearnModeIntroScreenState extends State<LearnModeIntroScreen> {
  bool _checked = true;

  @override
  void initState() {
    super.initState();
    _initLearningMode();
  }

  void _initLearningMode() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(Constants.prefLearnMore, true);
  }

  void _changeLearningModeStatus(bool checked) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(Constants.prefLearnMore, checked);
    setState(() {
      _checked = checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        Text(
          Languages.of(context)!.learningModeScreenExplanation,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        Row(
          children: [
            Checkbox(
              activeColor: Theme.of(context).colorScheme.primary,
              value: _checked,
              onChanged: (bool? checked) => _changeLearningModeStatus(checked!),
            ),
            Text(
              Languages.of(context)!.learningModeScreenLabel,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ],
    );
  }
}
