import 'package:flutter/material.dart';

import '../screens/account_screen/account.dart';
import '../screens/growth_garden/growth_garden.dart';
import '../screens/homescreen/homescreen.dart';
import '../screens/mindhub/mindhubscreen.dart';
import '../screens/safe_talks/safe_talks.dart';
import '../utils/constants/colors.dart';

class NavigationBarMenu extends StatefulWidget {
  @override
  _NavigationBarMenuState createState() => _NavigationBarMenuState();
}

class _NavigationBarMenuState extends State<NavigationBarMenu> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    GrowthGardenScreen(),
    SafeTalksScreen(),
    MindHubScreen(),
    AccountScreen(),
 ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Uplift",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.color1.withOpacity(1),
        elevation: 10,
        shadowColor: Colors.black.withOpacity(1),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Fixed for consistent spacing
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: MyColors.color1, // Highlight selected tab
        unselectedItemColor: Colors.grey, // Grey for unselected items
        selectedFontSize: 12, // Adjust selected font size
        unselectedFontSize: 10, // Adjust unselected font size
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.spa),
            label: 'Growth\nGarden', // Two-line label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Safe\nTalks', // Two-line label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'MindHub',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}




