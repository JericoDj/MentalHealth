import 'package:flutter/material.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  void showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Choose Theme',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Close dialog
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Light Theme'),
                leading: const Icon(Icons.light_mode, color: MyColors.color2),
                onTap: () {
                  // Apply Light Theme
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Dark Theme'),
                leading: const Icon(Icons.dark_mode, color: MyColors.color1),
                onTap: () {
                  // Apply Dark Theme
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.end,


        );
      },
    );
  }

  void showTextSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Choose Text Size',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Close dialog
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Small',style: TextStyle(fontSize: 14),),
                onTap: () {
                  // Apply Small Text Size
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Medium',style: TextStyle(fontSize: 18)),
                onTap: () {
                  // Apply Medium Text Size
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Large',style: TextStyle(fontSize: 22)),
                onTap: () {
                  // Apply Large Text Size
                  Navigator.pop(context);
                },
              ),
            ],
          ),


        );
      },
    );
  }

  void showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Close dialog
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Close dialog
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Handle password change logic
                Navigator.pop(context); // Close dialog
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 16,
                    color: MyColors.color1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          title: const Text('App Settings'),
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
                        Colors.orange, // Start - Orange
                        Colors.orangeAccent, // Stop 2 - Orange Accent
                        Colors.green, // Stop 3 - Green
                        Colors.greenAccent, // Stop 4 - Green Accent
                      ],
                      stops: const [0.0, 0.5, 0.5, 1.0], // Define stops at 50% transition
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Theme Settings
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: const Text(
                  'Theme',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Row(
                  children: [
                    const Text('Light ', style: TextStyle(color: MyColors.color2, fontWeight: FontWeight.w700),),
                    const Text('/', style: TextStyle(color: Colors.black87 ,fontWeight: FontWeight.bold),),
                    const Text(' Dark', style: TextStyle(color: MyColors.color1, fontWeight: FontWeight.w700),),

                  ],
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  showThemeDialog(context); // Open Theme Dialog
                },
              ),
            ),
            const SizedBox(height: 16),

            // Text Size Settings
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: const Text(
                  'Text Size',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text('Small / Medium / Large'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  showTextSizeDialog(context); // Open Text Size Dialog
                },
              ),
            ),
            const SizedBox(height: 16),

            // Change Password Settings
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: const Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text('Update your password'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  showChangePasswordDialog(context); // Open Change Password Dialog
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
