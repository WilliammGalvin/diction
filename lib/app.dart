import 'package:diction/favourites/view/favourites_page.dart';
import 'package:diction/search/view/search_page.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _pageIndex = 0;

  final _pages = [
    SearchPage(),
    const FavouritesPage(),
  ];

  final _navigationItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
  ];

  void _setPageIndex(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: _pages[_pageIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _setPageIndex,
        items: _navigationItems,
      ),
    );
  }
}
