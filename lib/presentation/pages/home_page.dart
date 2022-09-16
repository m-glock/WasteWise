import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/contact/contact_page.dart';
import 'package:recycling_app/presentation/pages/dashboard/dashboard_page.dart';
import 'package:recycling_app/presentation/pages/discovery/discover_page.dart';
import 'package:recycling_app/presentation/pages/neighborhood/neighborhood_page.dart';
import 'package:recycling_app/presentation/pages/profile/bookmark_page.dart';
import 'package:recycling_app/presentation/pages/profile/user_page.dart';
import 'package:recycling_app/presentation/pages/search/search_page.dart';
import 'package:recycling_app/presentation/pages/settings/settings_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycling_app/presentation/util/constants.dart';
import 'package:recycling_app/presentation/util/custom_icon_button.dart';

import 'imprint/imprint_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                    builder: (context) => const BookmarkPage()),
              )
            },
            icon: const Icon(FontAwesomeIcons.bookmark),
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
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 1.5,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Icon(Icons.recycling, size: 100), //TODO: logo?
            ),
            const Divider(thickness: 2.0),
            ListTile(
              leading: const Icon(FontAwesomeIcons.section),
              title: Text(
                Languages.of(context)!.imprintPageName,
                style: Theme.of(context).textTheme.headline3,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ImprintPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.envelope),
              title: Text(
                Languages.of(context)!.contactPageName,
                style: Theme.of(context).textTheme.headline3,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.gear),
              title: Text(
                Languages.of(context)!.settingsPageName,
                style: Theme.of(context).textTheme.headline3,
              ),
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
      body: Padding(
        padding: EdgeInsets.all(Constants.pagePadding),
        child: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
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
