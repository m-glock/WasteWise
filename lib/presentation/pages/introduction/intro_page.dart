import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/home_page.dart';
import 'package:recycling_app/presentation/pages/introduction/widgets/intro_app_purpose_widget.dart';
import 'package:recycling_app/presentation/pages/introduction/widgets/intro_language_widget.dart';
import 'package:recycling_app/presentation/pages/introduction/widgets/intro_user_data_widget.dart';
import 'package:recycling_app/presentation/pages/profile/widgets/login_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/constants.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  PageDecoration _getPageDecoration() {
    return PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.headline2!,
      titlePadding: const EdgeInsets.only(top: 40, bottom: 30),
      bodyTextStyle: Theme.of(context).textTheme.bodyText1!,
      bodyPadding: const EdgeInsets.symmetric(horizontal: 25),
    );
  }

  void _setIntroDone() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool(Constants.prefIntroDone, true);
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          //choose language
          title: Languages.of(context)!.languageScreenTitle,
          bodyWidget: const LanguageIntroScreen(),
          decoration: _getPageDecoration(),
        ),
        PageViewModel(
          // explain what the app is about
          title: Languages.of(context)!.purposeScreenTitle,
          bodyWidget: const AppPurposeIntroScreen(),
          decoration: _getPageDecoration(),
        ),
        PageViewModel(
          //choose municipality and show pictograms for waste bins
          title: Languages.of(context)!.municipalityScreenTitle,
          bodyWidget: const UserDataIntroScreen(),
          decoration: _getPageDecoration(),
        ),
        /*PageViewModel(
          // choose how you want to use the app
          title: "How do you want to use the app?",
          bodyWidget: const AppPurposeIntroScreen(),
          decoration: _getPageDecoration(),
        ),*/
        PageViewModel(
          title: Languages.of(context)!.profilePageName,
          bodyWidget: Column(
            children: [
              Text(
                Languages.of(context)!.profileScreenExplanation,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              LoginWidget(
                authenticated: () => {},
                onlySignup: true,
              ),
            ],
          ),
          decoration: _getPageDecoration(),
        ),
      ],
      onDone: () {
        _setIntroDone();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      },
      dotsDecorator: DotsDecorator(
        size: const Size(10.0, 10.0),
        color: Theme.of(context).colorScheme.surface,
        activeColor: Theme.of(context).colorScheme.primary,
        activeSize: const Size(22.0, 10.0),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      showSkipButton: true,
      skip: Text(
        Languages.of(context)!.skipButtonText,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      done: Text(
        Languages.of(context)!.doneButtonText,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      next: Text(
        Languages.of(context)!.nextButtonText,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}