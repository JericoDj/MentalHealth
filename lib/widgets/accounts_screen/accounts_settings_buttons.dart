import 'package:flutter/material.dart';
import '../../screens/account_screen/accounts_privacy/accounts_privacy_page.dart';
import '../../screens/account_screen/app_settings/app_settings_screen.dart';
import '../../screens/account_screen/notification_settings/notification_settings_page.dart';

import '../../../utils/constants/colors.dart';

class AccountSettingsButtons extends StatelessWidget {
  const AccountSettingsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildButton(
          text: 'App Settings',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AppSettingsPage(),
              ),
            );
          },
        ),
        const SizedBox(height: 10),

        _buildButton(
          text: 'Notification Settings',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationSettingsPage(),
              ),
            );
          },
        ),
        const SizedBox(height: 10),

        _buildButton(
          text: 'Account Privacy',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AccountPrivacyPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.color1,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
