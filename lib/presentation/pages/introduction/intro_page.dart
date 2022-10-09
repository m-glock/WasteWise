import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/introduction/widgets/intro_app_purpose_widget.dart';
import 'package:recycling_app/presentation/pages/introduction/widgets/intro_language_widget.dart';
import 'package:recycling_app/presentation/pages/introduction/widgets/intro_learning_mode.dart';
import 'package:recycling_app/presentation/pages/introduction/widgets/intro_login_widget.dart';
import 'package:recycling_app/presentation/pages/introduction/widgets/intro_user_data_widget.dart';
import 'package:recycling_app/presentation/pages/loading_page.dart';
import 'package:recycling_app/logic/data_holder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../logic/util/constants.dart';
import '../../../logic/database_access/graphl_ql_queries.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (DataHolder.municipalitiesById.isEmpty) {
      _setDefaultMunicipality();
    }
  }

  void _setDefaultMunicipality() async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult<Object?> result = await client.query(
      QueryOptions(document: gql(GraphQLQueries.municipalityQuery)),
    );

    List<dynamic> municipalities = result.data?["getMunicipalities"];
    for (dynamic municipality in municipalities) {
      DataHolder.municipalitiesById[municipality["objectId"]] =
          municipality["name"];
    }

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? municipalityId = DataHolder.municipalitiesById.entries.first.key;
    await _prefs.setString(
        Constants.prefSelectedMunicipalityCode, municipalityId);
  }

  PageDecoration _getPageDecoration() {
    return PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.headline2!,
      titlePadding: const EdgeInsets.only(top: 80, bottom: 30),
      bodyTextStyle: Theme.of(context).textTheme.bodyText1!,
      bodyPadding: const EdgeInsets.symmetric(horizontal: 25),
    );
  }

  Future<void> _setIntroDone() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool(Constants.prefIntroDone, true);
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          //choose language
          titleWidget: Text(
            Languages.of(context)!.languageScreenTitle,
            style: Theme.of(context).textTheme.headline1,
          ),
          bodyWidget: const LanguageIntroScreen(),
          decoration: _getPageDecoration(),
        ),
        PageViewModel(
          // explain what the app is about
          titleWidget: Text(
            Languages.of(context)!.purposeScreenTitle,
            style: Theme.of(context).textTheme.headline1,
          ),
          bodyWidget: const AppPurposeIntroScreen(),
          decoration: _getPageDecoration(),
        ),
        PageViewModel(
          // explain what the app is about
          titleWidget: Text(
            Languages.of(context)!.learningModeScreenTitle,
            style: Theme.of(context).textTheme.headline1,
          ),
          bodyWidget: const LearnModeIntroScreen(),
          decoration: _getPageDecoration(),
        ),
        PageViewModel(
          //choose municipality and show pictograms for waste bins
          titleWidget: Text(
            Languages.of(context)!.municipalityScreenTitle,
            style: Theme.of(context).textTheme.headline1,
          ),
          bodyWidget: const UserDataIntroScreen(),
          decoration: _getPageDecoration(),
        ),
        PageViewModel(
          titleWidget: Text(
            Languages.of(context)!.profilePageName,
            style: Theme.of(context).textTheme.headline1,
          ),
          bodyWidget: const IntroLoginWidget(),
          decoration: _getPageDecoration(),
        ),
      ],
      onDone: () async {
        await _setIntroDone();
        Route route =
            MaterialPageRoute(builder: (context) => const LoadingPage());
        Navigator.pushReplacement(context, route);
      },
      dotsDecorator: DotsDecorator(
        size: const Size(12.0, 12.0),
        spacing: const EdgeInsets.symmetric(horizontal: 4),
        color: Theme.of(context).colorScheme.surface,
        activeColor: Theme.of(context).colorScheme.primary,
        activeSize: const Size(20.0, 10.0),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      showBackButton: true,
      back: Text(
        Languages.of(context)!.backButtonText,
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
