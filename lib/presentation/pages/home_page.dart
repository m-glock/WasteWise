import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/pages/dashboard_page.dart';
import 'package:recycling_app/presentation/pages/discover_page.dart';
import 'package:recycling_app/presentation/pages/neighborhood_page.dart';
import 'package:recycling_app/presentation/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  final List<Widget> _pages = <Widget>[
    const DashboardPage(title: "Home"),
    const SearchPage(title: "Suche"),
    const DiscoverPage(title: "Entdecken"),
    const NeighborhoodPage(title: "Nachbarschaft"),
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
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Suche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Entdecken',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work),
            label: 'Nachbarschaft',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
