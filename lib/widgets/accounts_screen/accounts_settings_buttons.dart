import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class AccountSettingsButtons extends StatelessWidget {
  const AccountSettingsButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildButton(
          text: 'App Settings',
          onPressed: () {
            // Handle App Settings
          },
        ),
        const SizedBox(height: 10),

        _buildButton(
          text: 'Notification Settings',
          onPressed: () {
            // Handle Notification Settings
          },
        ),
        const SizedBox(height: 10),

        _buildButton(
          text: 'Account Privacy',
          onPressed: () {
            // Handle Account Privacy
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
          padding: const EdgeInsets.symmetric(vertical: 14),  // Padding inside button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),  // Button border radius
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,  // Text color for contrast
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
