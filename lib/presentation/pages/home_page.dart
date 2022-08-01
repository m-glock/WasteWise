import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/contact_page.dart';
import 'package:recycling_app/presentation/pages/dashboard_page.dart';
import 'package:recycling_app/presentation/pages/discover_page.dart';
import 'package:recycling_app/presentation/pages/imprint_page.dart';
import 'package:recycling_app/presentation/pages/neighborhood_page.dart';
import 'package:recycling_app/presentation/pages/notification_page.dart';
import 'package:recycling_app/presentation/pages/profile_page.dart';
import 'package:recycling_app/presentation/pages/search_page.dart';
import 'package:recycling_app/presentation/pages/settings_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    const DashboardPage(),
    const SearchPage(),
    const DiscoverPage(),
    const NeighborhoodPage(),
  ];

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
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationPage()),
                )
              },
              icon: const Icon(FontAwesomeIcons.bell),
          ),
          IconButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
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
      body: Center(
        child: _pages.elementAt(_selectedIndex),
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
