import 'package:flutter/material.dart';
import '../screens/account_screen/account.dart';
import '../screens/book_now/booknowscreen.dart';
import '../screens/growth_garden/growth_garden.dart';
import '../screens/homescreen/homescreen.dart';
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
    BookNowScreen(),
    SafeTalksScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 65,
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.2),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF8F8F8),
                  Color(0xFFF1F1F1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/logo/appbar_title.png',
                  height: MediaQuery.of(context).size.height * 0.06,
                  fit: BoxFit.contain,
                ),
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.9),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(Icons.support_agent, size: 26, color: MyColors.color2),
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
        ),

        body: _pages[_selectedIndex],

        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: MyColors.color1, width: 4.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.home, "Home", 0),
                  _buildNavItem(Icons.spa, "Growth Garden", 1),
                  SizedBox(width: 50),
                  _buildNavItem(Icons.group, "Safe Talks", 3),
                  _buildNavItem(Icons.person, "Account", 4),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: MediaQuery.of(context).size.width / 2 - 35,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => _onItemTapped(2),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: MyColors.color1, width: 4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'assets/images/logo/Logo_Square.png',
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onItemTapped(2),
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: MyColors.color1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(

            icon,
            color: _selectedIndex == index ? MyColors.color1 : Colors.grey.shade600,
          ),
          Text(

            label,
            style: TextStyle(
              letterSpacing: -0.05,
              fontSize: 12,
              color: _selectedIndex == index ? MyColors.color1 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
