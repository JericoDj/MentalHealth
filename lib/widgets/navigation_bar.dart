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
    MindHubScreen(),
    GrowthGardenScreen(),
    SafeTalksScreen(),
    AccountScreen(),
  ];

  final List<Color> _backgroundColors = [
    Colors.green.shade50,
    Colors.green.shade50,
    Colors.green.shade50,
    Colors.green.shade50,
    Colors.green.shade50,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: _backgroundColors[_selectedIndex], // Background color changes based on the selected tab
        ),
        child: _pages[_selectedIndex], // Display the selected page
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green.shade50,
        type: BottomNavigationBarType.fixed, // Fixed for consistent spacing
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: MyColors.color1, // Highlight selected tab
        unselectedItemColor: Colors.grey.shade600, // Grey for unselected items
        selectedFontSize: 12, // Adjust selected font size
        unselectedFontSize: 10, // Adjust unselected font size
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'MindHub',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.spa),
            label: 'Growth\nGarden', // Two-line label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Safe Talks', // Two-line label
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
