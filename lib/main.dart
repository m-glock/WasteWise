import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';
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
import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';

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
  String query = """
    query GetCategories(\$languageCode: String!, \$municipalityId: String!){
      getCategories(languageCode: \$languageCode, municipalityId: \$municipalityId){
        title
        category_id{
          objectId
          image_file{
            url
          }
          hex_color
        }
      }
    }
  """;

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
          options: QueryOptions(document: gql(query), variables: {
            "languageCode": _locale?.languageCode,
            "municipalityId": "PMJEteBu4m" //TODO get from user
          }),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) return Text(result.exception.toString());
            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            List<dynamic> categories = result.data?["getCategories"];

            if (categories.isEmpty) {
              return const Text("No tips found.");
            }

            for (dynamic element in categories) {
              DataHolder.categories.add(WasteBinCategory.fromJson(element));
            }

            return const HomePage(title: 'RecyclingApp');
          },
        ),
      ),
    );
  }
}
