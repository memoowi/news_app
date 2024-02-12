import 'package:flutter/material.dart';
import 'package:news_app/screens/headlines.dart';
import 'package:news_app/screens/search.dart';
import 'package:news_app/utils/custom_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  List<Widget> pages = [
    HeadlinesPage(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: CustomColors.secondaryColor,
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        _currentIndex == 0 ? 'News App' : 'Search',
      ),
      centerTitle: true,
      backgroundColor: CustomColors.primaryColor,
      foregroundColor: Colors.white,
      surfaceTintColor: CustomColors.primaryColor,
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      showUnselectedLabels: false,
      showSelectedLabels: true,
      backgroundColor: CustomColors.bgNavigationColor,
      selectedItemColor: CustomColors.primaryColor,
      unselectedItemColor: Colors.black38,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper),
          label: 'Headlines',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
      ],
    );
  }
}
