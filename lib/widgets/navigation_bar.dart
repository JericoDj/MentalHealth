import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/account_screen/account.dart';
import '../screens/book_now/booknowscreen.dart';
import '../screens/growth_garden/growth_garden.dart';
import '../screens/homescreen/homescreen.dart';
import '../screens/safe_talks/safe_talks.dart';
import '../utils/constants/colors.dart';
import 'accounts_screen/TIcket_Popup_widget.dart';
import 'curved clipper.dart';

class NavigationBarMenu extends StatefulWidget {
  final bool dailyCheckIn; // Flag to check if the user just logged in


  const NavigationBarMenu({Key? key, required this.dailyCheckIn}) : super(key: key);

  @override
  _NavigationBarMenuState createState() => _NavigationBarMenuState();
}

class _NavigationBarMenuState extends State<NavigationBarMenu> {
  int _selectedIndex = 0;
  late List<Widget> _pages; // Declare the list as late

  @override
  void initState() {
    super.initState();

    // Initialize the _pages list inside initState
    _pages = [
      HomeScreen(),
      GrowthGardenScreen(),
      BookNowScreen(),
      SafeTalksScreen(
        onBackToHome: () {
          setState(() {
            _selectedIndex = 0; // Switch to HomeScreen
          });
        },
      ),
      AccountScreen(),
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.dailyCheckIn) {
        _showMoodDialog();
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Handle back button press
  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      // If not on the Home screen, navigate to Home
      setState(() {
        _selectedIndex = 0;
      });
      return false; // Prevent default back behavior
    } else {
      // If on the Home screen, show exit confirmation dialog
      final shouldExit = await showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text("Exit App"),
              content: const Text("Are you sure you want to exit?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false), // Cancel
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true), // Exit
                  child: const Text("Exit"),
                ),
              ],
            ),
      );
      return shouldExit ?? false; // Return true to exit, false to stay
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Intercept back button press
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,


            toolbarHeight: 65,
            flexibleSpace: Stack(
              children: [


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
                          Colors.orange, // Start - Orange
                          Colors.orangeAccent, // Stop 2 - Orange Accent
                          Colors.green, // Stop 3 - Green
                          Colors.greenAccent, // Stop 4 - Green Accent
                        ],
                        stops: const [0.0, 0.5, 0.5, 1.0],
                        // Define stops at 50% transition
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    child: Image.asset(
                      'assets/images/logo/appbar_title.png',
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.06,
                      fit: BoxFit.contain,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() =>
                          SupportTicketsPage()); // Correct usage of Get.to()
                    },
                    child: Container(


                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.7),
                        border: Border.all(color: MyColors.color2, width: 2),
                      ),
                      child: Icon(Icons.support_agent, size: 26,
                          color: MyColors.color2),
                    ),
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
                decoration: const BoxDecoration(
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
                                Colors.green, // Start - Green
                                MyColors.color1, // Stop 2
                                MyColors.color2, // Stop 3
                                Colors.orangeAccent, // Stop 4 - Orange Accent
                              ],
                              stops: const [0.0, 0.5, 0.5, 1.0],
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
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildNavItem(Icons.home, "Home", 0),
                            _buildNavItem(Icons.spa, "Growth Garden", 1),
                            const SizedBox(width: 50),
                            // Space for floating button
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
              Positioned(
                bottom: 8,
                left: (MediaQuery
                    .of(context)
                    .size
                    .width > 510)
                    ? (510 / 2) -
                    27.5 // Use fixed width when screen is wider than 500px (desktop web)
                    : (MediaQuery
                    .of(context)
                    .size
                    .width / 2) - 27.5, // Dynamic center for mobile
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
                          color: _selectedIndex == 2 ? MyColors.color1 : Colors
                              .grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
            color: _selectedIndex == index ? MyColors.color1 : Colors.grey
                .shade600,
          ),
          Text(
            label,
            style: TextStyle(
              letterSpacing: -0.5,
              fontSize: 12,
              color: _selectedIndex == index ? MyColors.color1 : Colors.grey
                  .shade600,
            ),
          ),
        ],
      ),
    );
  }

  // Show Mood Selection Dialog with Stress Level
  void _showMoodDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (context) {
        double _stressLevel = 50.0; // Default stress level percentage
        String _selectedMood = ""; // Store the selected mood emoji
        String _moodTemp = ""; // Temporary mood selection until confirmed

        return StatefulBuilder(
          builder: (dialogContext, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title with Exit Icon
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "How are you feeling today?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(
                              Icons.close, color: Colors.red, size: 24),
                          onPressed: () =>
                              Navigator.pop(dialogContext), // Use dialogContext
                        ),
                      ],
                    ),
                  ),


                  // Mood Emojis
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildMoodEmoji(
                            dialogContext, "😃", "Happy", _moodTemp, () {
                          setState(() {
                            _moodTemp = "Happy"; // Set temporary selected mood
                          });
                        }),
                        _buildMoodEmoji(
                            dialogContext, "😐", "Neutral", _moodTemp, () {
                          setState(() {
                            _moodTemp = "Neutral"; // Set temporary selected mood
                          });
                        }),
                        _buildMoodEmoji(
                            dialogContext, "😔", "Sad", _moodTemp, () {
                          setState(() {
                            _moodTemp = "Sad"; // Set temporary selected mood
                          });
                        }),
                        _buildMoodEmoji(
                            dialogContext, "😡", "Angry", _moodTemp, () {
                          setState(() {
                            _moodTemp = "Angry"; // Set temporary selected mood
                          });
                        }),
                        _buildMoodEmoji(
                            dialogContext, "😰", "Anxious", _moodTemp, () {
                          setState(() {
                            _moodTemp = "Anxious"; // Set temporary selected mood
                          });
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Stress Level Section
                  const Text(
                    "Stress Level",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Slider(

                        activeColor: MyColors.color2,
                        value: _stressLevel,
                        min: 0,
                        max: 100,

                        divisions: 10,
                        label: '${_stressLevel.toStringAsFixed(0)}%',
                        onChanged: (double value) {
                          setState(() {
                            _stressLevel = value;
                          });
                        },
                      ),
                      Text(
                        '${_stressLevel.toStringAsFixed(0)}%',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Confirm GestureDetector
                  GestureDetector(
                    onTap: () {
                      if (_moodTemp.isNotEmpty) {
                        _selectedMood =
                            _moodTemp; // Set selected mood on confirm
                        ScaffoldMessenger.of(dialogContext).showSnackBar(
                          SnackBar(
                            content: Text(
                                "You selected: $_selectedMood with Stress Level: ${_stressLevel
                                    .toStringAsFixed(0)}%"),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(dialogContext).showSnackBar(
                          const SnackBar(
                            content: Text("Please select a mood first!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                      Navigator.pop(dialogContext); // Close dialog on confirm
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      decoration: BoxDecoration(
                        color: MyColors.color1,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }
// Build a Mood Emoji Button with selection highlight
  Widget _buildMoodEmoji(BuildContext dialogContext, String emoji, String mood,
      String selectedMood, Function onTap) {
    bool isSelected = selectedMood == mood; // Check if this mood is selected
    return GestureDetector(
      onTap: () {
        onTap(); // Set the temporary selected mood without closing the dialog
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSelected ? MyColors.color2.withValues(alpha: 0.2) : Colors.transparent,
          // Highlight selected mood
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? MyColors.color2 : Colors.transparent,
            // Add border when selected
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(
              emoji,
              style: TextStyle(
                fontSize: 30,
                color: isSelected ? Colors.black : Colors
                    .black87, // Change color when selected
              ),
            ),
            const SizedBox(height: 5),
            Text(
              mood,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.black : Colors
                    .black87, // Highlight the mood text
              ),
            ),
          ],
        ),
      ),
    );
  }
}