import 'package:flutter/material.dart';
import 'package:llps_mental_app/widgets/accounts_screen/consultation_status_widget.dart';
import 'package:llps_mental_app/widgets/accounts_screen/logout_button.dart';

import '../../widgets/accounts_screen/accounts_settings_buttons.dart';
import '../../widgets/accounts_screen/contact_support_section.dart';
import '../../widgets/accounts_screen/user_account_section.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserAccountSection(),
                SizedBox(height: 20),
      
                ConsultationStatusWidget(),
      
                SizedBox(height: 20),
      
                // Account Settings Button
                AccountSettingsButtons(),
      
                SizedBox(height: 20),
      
                // Support Container
                ContactSupportSection(),
                SizedBox(height: 20),
      
                // Logout Button
                LogoutButton(),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
