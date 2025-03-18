import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/constants/colors.dart';

void showDetailDialog({
  required BuildContext context,
  required String serviceType,
  required String serviceId,
  required String status,
  required String bookedDate,
  required String bookedTime,
  required String createdDate,
  required String createdTime,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.all(16),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                'Consultation Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: MyColors.color1,
                ),
              ),
              const SizedBox(height: 20),

              // Service Type (Fully Visible)
              Text(
                'Service Type: $serviceType',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              // Service ID (Ellipsis + Copyable)
              _buildCopyableRow(
                label: 'Service ID:',
                value: serviceId,
                context: context,
              ),

              const SizedBox(height: 10),

              // Status
              Text(
                'Status: $status',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: status.toLowerCase() == 'completed'
                      ? Colors.green
                      : Colors.orange,
                ),
              ),
              const SizedBox(height: 10),

              // Booked Date
              Text(
                'Booked Date: $bookedDate',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),

              // Booked Time
              Text(
                'Booked Time: $bookedTime',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),

              // Created Date
              Text(
                'Created Date: $createdDate',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),

              // Created Time
              Text(
                'Created Time: $createdTime',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              // Close Button
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          MyColors.color1,
                          Colors.green,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// ─────────────────────────────────────────────────────────────
// ✅ Utility: Copyable Row with Text Ellipsis (ONLY for Service ID)
// ─────────────────────────────────────────────────────────────
Widget _buildCopyableRow({
  required String label,
  required String value,
  required BuildContext context,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        '$label ',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      Expanded(
        child: Tooltip(
          message: value, // Show full value on hover (Desktop)
          child: GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: value));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Service ID copied to clipboard!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blue, // Indicate it's copyable
              ),
              overflow: TextOverflow.ellipsis, // ✅ Prevents long overflow
              maxLines: 1,
            ),
          ),
        ),
      ),
      const SizedBox(width: 8),
      GestureDetector(
        onTap: () {
          Clipboard.setData(ClipboardData(text: value));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Service ID copied to clipboard!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Icon(
          Icons.copy,
          size: 20,
          color: MyColors.color1,
        ),
      ),
    ],
  );
}
