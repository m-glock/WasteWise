import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/home_page.dart';
import 'package:recycling_app/presentation/pages/introduction/widgets/intro_app_purpose_widget.dart';
import 'package:recycling_app/presentation/pages/introduction/widgets/intro_language_widget.dart';
import 'package:recycling_app/presentation/pages/introduction/widgets/intro_login_widget.dart';
import 'package:recycling_app/presentation/pages/introduction/widgets/intro_user_data_widget.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';
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
          bodyWidget: const IntroLoginWidget(),
          decoration: _getPageDecoration(),
        ),
      ],
      onDone: () async {
        _setIntroDone();
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        bool municipalityNotSet =
            _prefs.getString(Constants.prefSelectedMunicipalityCode) == null;
        if(municipalityNotSet){
          String? municipalityId =
              DataHolder.municipalitiesById.entries.first.key;
          await _prefs.setString(
              Constants.prefSelectedMunicipalityCode,
              municipalityId
          );
        }
        Route route = MaterialPageRoute(builder: (context) => const HomePage());
        Navigator.pushReplacement(context, route);
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
