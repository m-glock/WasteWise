import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/pages/home_page.dart';
import 'package:recycling_app/presentation/themes/appbar_theme.dart';
import 'package:recycling_app/presentation/themes/button_theme.dart';
import 'package:recycling_app/presentation/themes/color_scheme.dart';
import 'package:recycling_app/presentation/themes/navigationbar_theme.dart' as navbar;
import 'package:recycling_app/presentation/i18n/app_localizations_delegate.dart';
import 'package:recycling_app/presentation/i18n/locale_constant.dart';
import 'package:recycling_app/presentation/themes/text_theme.dart';

void main() async {

  // initialize connection to backend
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'tqa1Cgvy94m9L6i7tFTMPXMVYANwy4qELWhzf5Nh';
  const keyClientKey = 'YveWcquaobxddd2VALkC37Oej5MXCNO9kUcKevuW';
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
    return MaterialApp(
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
      supportedLocales: const [
        Locale('en', ''),
        Locale('de', '')
      ],
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
      home: const HomePage(title: 'RecyclingApp'),
    );
  }

}