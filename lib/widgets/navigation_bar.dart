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
    BookNowScreen(), // Now works correctly
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
          elevation: 4, // Adds shadow effect
          shadowColor: Colors.black.withOpacity(0.2),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF8F8F8), // Soft off-white
                  Color(0xFFF1F1F1), // Light grey
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          title: Stack(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/logo/appbar_title.png',
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    Container(
                      height: 42,
                      width: 42,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [MyColors.color2, MyColors.color2],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                          Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [MyColors.color2, MyColors.color2],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds);
                              },
                              child: const Icon(
                                Icons.support_agent,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),

        body: _pages[_selectedIndex], // Display selected page

        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipPath(
              clipper: CurvedNavBarClipper(),
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white, // Solid white background
                  border: Border(
                    top: BorderSide(
                      color: MyColors.color1, // Border color at the top
                      width: 4.0, // Thickness of the border
                    ),
                  ),
                ),
              ),
            ),

            // Floating Center Button (Now Clickable & Positioned Correctly)
            Positioned(
              bottom: 10, // Adjusted to lift button slightly higher
              left: MediaQuery.of(context).size.width / 2 - (MediaQuery.of(context).size.width / 18),
              child: GestureDetector(
                onTap: () => _onItemTapped(2), // Book Now screen navigation
                child: Column(
                  children: [
                    Container(
                      width: 56, // Same as default FloatingActionButton size
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.topRight,
                          stops: [0.0, 1.0], // 3 stops for gradient transition
                          colors: [
                            Colors.orange,         // Top-left gradient start (Green)
                            MyColors.color2,      // Transition to MyColors.color1 at top-center
                               // Transition to Orange at top-right
                          ],
                        ),
                        border: Border.all(color: Colors.white, width: 2), // Outer white border
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3), // Inner padding to show gradient border
                        child: CircleAvatar(
                          backgroundColor: Colors.white, // Inner circle white background
                          child: Image.asset(
                            'assets/images/logo/Logo_Square.png',  // Your logo file
                            width: 30, // Adjust size as needed
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2), // Spacing between FAB & text
                    Text(
                      "Book Now",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Navigation Bar Items
            Padding(
              padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
              child: Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(flex: 2, child: _buildNavItem(Icons.home, "Home", 0)),  // Wider
                      Flexible(flex: 3, child: _buildNavItem(Icons.spa, "Growth Garden", 1)), // Equal width
                      Flexible(flex: 2, child: SizedBox(width: 50,)), // Space for Floating Button

                      Flexible(flex: 2, child: _buildNavItem(Icons.group, "Safe Talks", 3)), // Equal width
                      Flexible(flex: 2, child: _buildNavItem(Icons.person, "Account", 4)),  // Wider
                    ],
                  ),
                ),
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
              fontSize: 12,
              color: _selectedIndex == index ? MyColors.color1 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Curved Navigation Bar Shape
class CurvedNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;

    Path path = Path()
      ..moveTo(0, height) // Start from bottom-left
      ..lineTo(width * 0.4, height) // Left part
      ..quadraticBezierTo(width * 0.5, height - 35, width * 0.6, height) // Curved notch
      ..lineTo(width, height) // Right part
      ..lineTo(width, 0) // Top right
      ..lineTo(0, 0) // Top left
      ..close(); // Close path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
