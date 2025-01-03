import 'package:flutter/material.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme Settings
          ListTile(
            title: const Text('Theme'),
            subtitle: const Text('Light / Dark / System Default'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to Theme settings
            },
          ),
          const Divider(),

          // Text Size Settings
          ListTile(
            title: const Text('Text Size'),
            subtitle: const Text('Adjust app text size'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to Text Size settings
            },
          ),
          const Divider(),

          // AI Button Toggle
          SwitchListTile(
            title: const Text('Enable AI Features'),
            subtitle: const Text('Activate AI-powered assistance'),
            value: true,
            onChanged: (bool value) {
              // Toggle AI features
            },
          ),
          const Divider(),

          // Notifications Settings
          ListTile(
            title: const Text('Notifications'),
            subtitle: const Text('Manage notification preferences'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to Notification settings
            },
          ),
        ],
      ),
    );
  }
}