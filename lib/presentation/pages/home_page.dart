import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/contact/contact_page.dart';
import 'package:recycling_app/presentation/pages/dashboard/dashboard_page.dart';
import 'package:recycling_app/presentation/pages/discovery/discover_page.dart';
import 'package:recycling_app/presentation/pages/neighborhood/neighborhood_page.dart';
import 'package:recycling_app/presentation/pages/profile/user_page.dart';
import 'package:recycling_app/presentation/pages/search/search_page.dart';
import 'package:recycling_app/presentation/pages/settings/settings_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycling_app/presentation/util/constants.dart';
import 'package:recycling_app/presentation/util/custom_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../i18n/locale_constant.dart';
import '../util/graphl_ql_queries.dart';
import 'imprint/imprint_page.dart';
import 'notification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? languageCode;
  String? municipalityId;
  String? userId;
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    const DashboardPage(),
    const SearchPage(),
    const DiscoverPage(),
    const NeighborhoodPage()
  ];

  @override
  void initState() {
    super.initState();
    _getLanguageCodeAndMunicipality();
  }

  void _getLanguageCodeAndMunicipality() async {
    Locale locale = await getLocale();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? id = _prefs.getString(Constants.prefSelectedMunicipalityCode);
    ParseUser? currentUser = await ParseUser.currentUser();
    setState(() {
      languageCode = locale.languageCode;
      municipalityId = id ?? "";
      userId = currentUser?.objectId ?? "";
    });
  }

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appTitle),
        actions: [
          IconButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationPage()),
              )
            },
            icon: const Icon(FontAwesomeIcons.bell),
          ),
          CustomIconButton(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserPage()),
              )
            },
            icon: const Icon(FontAwesomeIcons.user),
          ),
        ],
        titleSpacing: 2.0,
      ),
      //TODO: proper design
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: Text(Languages.of(context)!.imprintPageName),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ImprintPage()),
                );
              },
            ),
            ListTile(
              title: Text(Languages.of(context)!.contactPageName),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactPage()),
                );
              },
            ),
            ListTile(
              title: Text(Languages.of(context)!.settingsPageName),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: languageCode == null || municipalityId == null
          ? const Center(child: CircularProgressIndicator())
          : Query(
              options: QueryOptions(
                  document: gql(GraphQLQueries.initialQuery),
                  variables: {
                    "languageCode": languageCode,
                    "municipalityId": municipalityId,
                    "userId": userId,
                  }),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }
                if (result.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                GraphQLQueries.initialDataExtraction(result.data);

                return Padding(
                  padding: EdgeInsets.all(Constants.pagePadding),
                  child: Center(
                    child: _pages.elementAt(_selectedIndex),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(size: 30),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.house),
            label: Languages.of(context)!.homePageName,
          ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
            label: Languages.of(context)!.searchPageName,
          ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.bookOpen),
            label: Languages.of(context)!.discoveryPageName,
          ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.peopleGroup),
            label: Languages.of(context)!.neighborhoodPageName,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
