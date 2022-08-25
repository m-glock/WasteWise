import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/util/graphl_ql_queries.dart';
import 'package:recycling_app/presentation/pages/home_page.dart';
import 'package:recycling_app/presentation/themes/appbar_theme.dart';
import 'package:recycling_app/presentation/themes/button_theme.dart';
import 'package:recycling_app/presentation/themes/color_scheme.dart';
import 'package:recycling_app/presentation/themes/navigationbar_theme.dart'
    as navbar;
import 'package:recycling_app/presentation/i18n/app_localizations_delegate.dart';
import 'package:recycling_app/presentation/i18n/locale_constant.dart';
import 'package:recycling_app/presentation/themes/text_theme.dart';
import 'package:recycling_app/presentation/util/constants.dart';

void main() async {
  // initialize connection to backend
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = Constants.kParseApplicationId;
  const keyClientKey = Constants.kParseClientKey;
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  // start app
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    // update language
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      Constants.apiURL,
      defaultHeaders: {
        'X-Parse-Application-Id': Constants.kParseApplicationId,
        'X-Parse-Client-Key': Constants.kParseClientKey,
      }, //getheaders()
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(), //TODO: check which Cache to use
        link: httpLink,
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: "RecyclingApp",
        theme: ThemeData(
          appBarTheme: const TopAppBarTheme(),
          bottomNavigationBarTheme: const navbar.NavigationBarTheme(),

          elevatedButtonTheme: const AppElevatedButtonTheme(),
          floatingActionButtonTheme: const AppFloatingActionButtonTheme(),
          outlinedButtonTheme: const AppOutlinedButtonTheme(),
          textButtonTheme: AppTextButtonTheme(),
          toggleButtonsTheme: const AppToggleButtonsTheme(),

          colorScheme: const AppColorScheme(),

          //TODO: add PageTransitionsTheme
          //pageTransitionsTheme: const PageTransitionsTheme(),

          textTheme: const AppTextTheme(),
        ),
        locale: _locale,
        supportedLocales: const [Locale('en', ''), Locale('de', '')],
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode &&
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: Query(
          options: QueryOptions(document: gql(GraphQLQueries.initialQuery), variables: {
            "languageCode": _locale?.languageCode,
            "municipalityId": "PMJEteBu4m" //TODO get from user
          }),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) return Text(result.exception.toString());
            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            GraphQLQueries.initialDataExtraction(result.data);

            return const HomePage(title: 'RecyclingApp');
          },
        ),
      ),
    );
  }
}
