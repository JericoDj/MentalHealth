import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../screens/account_screen/account.dart';
import '../screens/book_now/booknowscreen.dart';
import '../screens/growth_garden/growth_garden.dart';
import '../screens/homescreen/homescreen.dart';
import '../screens/safe_talks/safe_talks.dart';
import '../utils/constants/colors.dart';
import 'curved clipper.dart';

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
          flexibleSpace: Stack(
            children: [
              Container(
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
              /// Gradient Bottom Border
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 2, // Border thickness
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange,         // Start - Orange
                        Colors.orangeAccent,   // Stop 2 - Orange Accent
                        Colors.green,          // Stop 3 - Green
                        Colors.greenAccent,    // Stop 4 - Green Accent
                      ],
                      stops: [0.0, 0.5, 0.5, 1.0], // Define stops at 50% transition
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ],

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
                    color: Colors.white.withOpacity(0.7),
                    border: Border.all(color: MyColors.color2, width: 2),
                  ),
                  child: Icon(Icons.support_agent, size: 26, color: MyColors.color2),
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
        ),


        body: Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: _pages[_selectedIndex],
        ),

        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            /// Bottom Navigation Bar
            Container(
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  /// Curved Gradient Top Border
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: ClipPath(
                      clipper: CurvedBorderClipper(),
                      child: Container(
                        height: 2, // Adjust height to control curvature depth
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.green,         // Start - Green
                              MyColors.color1,      // Stop 2
                              MyColors.color2,      // Stop 3
                              Colors.orangeAccent,  // Stop 4 - Orange Accent
                            ],
                            stops: [0.0, 0.5, 0.5, 1.0],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Navigation Row
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildNavItem(Icons.home, "Home", 0),
                          _buildNavItem(Icons.spa, "Growth Garden", 1),
                          SizedBox(width: 50), // Space for floating button
                          _buildNavItem(Icons.group, "Safe Talks", 3),
                          _buildNavItem(Icons.person, "Account", 4),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Floating Center Button
            /// Floating Center Button
            Positioned(
              bottom: 8,
              left: (MediaQuery.of(context).size.width > 510)
                  ? (510 / 2) - 27.5  // Use fixed width when screen is wider than 500px (desktop web)
                  : (MediaQuery.of(context).size.width / 2) - 27.5,  // Dynamic center for mobile
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => _onItemTapped(2),
                    child: Container(
                      width: 55,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 6),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/logo/Logo_No_Background_No_SQUARE.png',
                        width: 30,
                        height: 30,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onItemTapped(2),
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                        letterSpacing: -1,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: _selectedIndex == 2 ? MyColors.color1 : Colors.grey,
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
              letterSpacing: -0.5 ,
              fontSize: 12,
              color: _selectedIndex == index ? MyColors.color1 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
