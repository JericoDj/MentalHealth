  import 'package:flutter/material.dart';
  import 'package:google_fonts/google_fonts.dart';
  
  import '../screens/account_screen/account.dart';
  import '../screens/book_now/booknowscreen.dart';
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
      BookNowScreen(),
      SafeTalksScreen(),
      AccountScreen(),
    ];

    final List<BoxDecoration> _backgroundGradients = [
      BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF8F8F8), Color(0xFFF1F1F1)], // Soft grey gradient
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF8F8F8), Color(0xFFF1F1F1)], // Warm beige tones
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF8F8F8), Color(0xFFF1F1F1)], // Light blue sky feel
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFAF3E0), Color(0xFFFFE3B3)], // Soft red-pink gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFAF3E0), Color(0xFFFFE3B3)], // Soft red-pink gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFAF3E0), Color(0xFFFFE3B3)], // Green pastel
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  
    Future<bool?> _showExitConfirmationDialog() async {
      return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Exit App"),
            content: Text("Are you sure you want to exit?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Exit"),
              ),
            ],
          );
        },
      );
    }
  
  
  
    @override
    Widget build(BuildContext context) {
      return PopScope(
        canPop: _selectedIndex == 0, // Allow popping only when on home screen
        onPopInvoked: (didPop) async {
          if (!didPop) {
            if (_selectedIndex != 0) {
              setState(() {
                _selectedIndex = 0; // Reset to Home tab instead of exiting
              });
            } else {
              bool? shouldExit = await _showExitConfirmationDialog();
              if (shouldExit ?? false) {
                Navigator.of(context).pop(); // Exit the app
              }
            }
          }
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 65,
              elevation: 4, // Adds slight shadow effect
              shadowColor: Colors.black.withOpacity(0.2), // Subtle shadow
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFF8F8F8), // Soft off-white
                      Color(0xFFF1F1F1), // Light grey for contrast
                    ],
                    stops: [0.0, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26, // Subtle shadow color
                      blurRadius: 6, // Blur effect
                      spreadRadius: 2, // Spreading the shadow
                      offset: Offset(0, 3), // Move shadow downward
                    ),
                  ],
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFE0E0E0), // Softer grey for divider
                      width: 1,
                    ),
                  ),
                ),
              ),
              title: Stack(
                children: [
                  // Centered Logo
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/logo/Logo_Square.png',
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // First Image (Left-aligned) - Removed Padding
                        Image.asset(
                          'assets/images/logo/appbar_title.png',
                          height: 40,
                          fit: BoxFit.contain,
                        ),
                        // Customer Support Icon (Right-aligned)
                        Container(
                          height: 42, // Increased to accommodate border
                          width: 42,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Outer Gradient Border
                              Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      MyColors.color2,
                                      MyColors.color2,
                                    ], // Green gradient
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                              // Inner White Circle
                              Container(
                                height: 38, // Slightly smaller to create border effect
                                width: 38,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9), // White background
                                  shape: BoxShape.circle,
                                ),
                                child: ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return LinearGradient(
                                      colors: [
                                        MyColors.color2,
                                        MyColors.color2,
                                      ], // Gradient for the icon
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ).createShader(bounds);
                                  },
                                  child: const Icon(
                                    Icons.support_agent,
                                    size: 26,
                                    color: Colors.white, // Overridden by ShaderMask
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


            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
                decoration: _backgroundGradients[_selectedIndex], // Dynamically applied gradient
                child: _pages[_selectedIndex],
              ),
            ),
          
          
          
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
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
                  icon: Icon(Icons.menu_book),
                  label: 'Book Now',
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
          ),
        ),
      );
    }
  }
