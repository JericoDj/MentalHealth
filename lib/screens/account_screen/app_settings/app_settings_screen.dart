import 'package:flutter/material.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
      ),
      body: const Center(
        child: Text(
          'App Settings Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
