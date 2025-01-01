import 'package:flutter/material.dart';

class AccountPrivacyPage extends StatelessWidget {
  const AccountPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Privacy'),
      ),
      body: const Center(
        child: Text(
          'Account Privacy Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
