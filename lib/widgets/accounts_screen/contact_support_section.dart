import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'TIcket_Popup_widget.dart';

class ContactSupportSection extends StatelessWidget {
  const ContactSupportSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Need Help?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              'Contact our support team for assistance.',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),

          // Phone Number Section
          Row(
            children: [
              const Icon(Icons.phone, color: Colors.green),
              const SizedBox(width: 10),
              Text(
                '+63 917 854 2236',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Email Section
          Row(
            children: [
              const Icon(Icons.email, color: Colors.green),
              const SizedBox(width: 10),
              Text(
                'support@llps.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Submit Ticket Button
          Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Handle ticket submission
                  Get.to(
                    () => SupportTicketsPage(
                    ),
                  );
                },
                child: const Text(
                  'Submit a Ticket',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
