import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/pages/introduction/intro_page.dart';
import 'package:recycling_app/presentation/pages/loading_page.dart';
import 'package:recycling_app/presentation/themes/button_theme.dart';
import 'package:recycling_app/presentation/themes/color_scheme.dart';
import 'package:recycling_app/presentation/i18n/app_localizations_delegate.dart';
import 'package:recycling_app/presentation/i18n/locale_constant.dart';
import 'package:recycling_app/presentation/themes/text_theme.dart';
import 'package:recycling_app/presentation/util/constants.dart';
import 'package:recycling_app/presentation/util/database_classes/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';

void main() async {
  // initialize connection to backend
  WidgetsFlutterBinding.ensureInitialized();
  String keyApplicationId = Constants.kParseApplicationId;
  String keyClientKey = Constants.kParseClientKey;
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  // start app
  runApp(
    ChangeNotifierProvider<User>(
      create: (context) => User(),
      child: const MyApp(),
    ));
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
  bool _introDone = false;
  ValueNotifier<GraphQLClient>? _client;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    // update language
    Locale locale = await getLocale();
    // update intro done
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool done = _prefs.getBool(Constants.prefIntroDone) ?? false;
    ValueNotifier<GraphQLClient> newClient = await _getClient();

    setState(() {
      _locale = locale;
      _introDone = done;
      _client = newClient;
    });
    super.didChangeDependencies();
  }

  Future<ValueNotifier<GraphQLClient>> _getClient() async {
    final HttpLink httpLink = HttpLink(
      Constants.apiURL,
      defaultHeaders: {
        'X-Parse-Application-Id': Constants.kParseApplicationId,
        'X-Parse-Client-Key': Constants.kParseClientKey,
      },
    );

    // initialize Hive and wrap the default box in a HiveStore
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    final store = await HiveStore.open(path: directory.path);
    return ValueNotifier(
      GraphQLClient(
        defaultPolicies: DefaultPolicies(
          query: Policies(
            fetch: FetchPolicy.cacheAndNetwork,
            cacheReread: CacheRereadPolicy.mergeOptimistic
          )
        ),
        cache: GraphQLCache(store: store),
        link: httpLink,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _client == null
        ? const Center(child: CircularProgressIndicator())
        : GraphQLProvider(
            client: _client,
            child: MaterialApp(
              title: Constants.appTitle,
              theme: ThemeData(
                elevatedButtonTheme: AppElevatedButtonTheme(),
                outlinedButtonTheme: AppOutlinedButtonTheme(),
                textButtonTheme: AppTextButtonTheme(),
                colorScheme: const AppColorScheme(),
                textTheme: const AppTextTheme(),
              ),
              locale: _locale,
              supportedLocales: Constants.languages.keys,
              localizationsDelegates: const [
                AppLocalizationsDelegate(),
                GlobalWidgetsLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
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
              home: _introDone ? const LoadingPage() : const IntroductionPage(),
            ),
          );
  }
}
