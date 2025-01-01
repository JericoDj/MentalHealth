import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.redAccent, width: 2), // Red border
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.white, // White button background
        ),
        onPressed: () {
          _performLogout(context);
        },
        child: const Text(
          'Log Out',
          style: TextStyle(
            color: Colors.redAccent,  // Red text
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _performLogout(BuildContext context) {
    // Add your logout logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully logged out.'),
        backgroundColor: Colors.redAccent,
      ),
    );
    Navigator.of(context).pushReplacementNamed('/login');
  }
}
