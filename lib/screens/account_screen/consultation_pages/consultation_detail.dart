import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // ✅ Import for date formatting
import '../../../utils/constants/colors.dart';

void showDetailDialog({
  required BuildContext context,
  required String serviceType,
  required String serviceId,
  required String status,
  required String bookedDate,
  required String bookedTime,
  required String createdDate,
  String? meetingLink, // ✅ Nullable - Only shown if scheduled
  String? specialist, // ✅ Nullable - Only shown if scheduled
}) {
  // ✅ Extract Date & Time Properly
  String formattedCreatedDate = createdDate.split(' ')[0]; // Extracts YYYY-MM-DD
  String formattedCreatedTime = DateFormat.jm().format(DateTime.parse(createdDate)); // Converts to AM/PM format

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.all(16),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔹 Title
              Text(
                'Consultation Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: MyColors.color1,
                ),
              ),
              const SizedBox(height: 20),

              // 🔹 Service Type
              _buildDetailRow(label: 'Service Type:', value: serviceType),

              // 🔹 Service ID (Ellipsis + Copyable)
              _buildCopyableRow(label: 'Service ID:', value: serviceId, context: context),

              // 🔹 Status with Color Indicator
              Text(
                'Status: $status',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: _getStatusColor(status),
                ),
              ),
              const SizedBox(height: 10),

              // 🔹 Display Meeting Link & Specialist ONLY if status is "Scheduled"
              if (status.toLowerCase() == 'scheduled') ...[
                _buildCopyableRow(
                  label: 'Meeting Link:',
                  value: meetingLink ?? "Not Provided",
                  context: context,
                ),
                _buildDetailRow(
                  label: 'Specialist:',
                  value: specialist ?? "Not Assigned",
                ),
              ],

              // 🔹 Booked Date & Time
              _buildDetailRow(label: 'Booked Date:', value: bookedDate),
              _buildDetailRow(label: 'Booked Time:', value: bookedTime),

              // 🔹 Created Date & Time
              _buildDetailRow(label: 'Created Date:', value: formattedCreatedDate),
              _buildDetailRow(label: 'Created Time:', value: formattedCreatedTime),

              const SizedBox(height: 20),

              // 🔹 Close Button
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [MyColors.color1, Colors.green],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.color2.withOpacity(0.3),
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

/// ✅ **Helper Method: Build a Simple Detail Row**
Widget _buildDetailRow({required String label, required String value}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      '$label $value',
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );
}

/// ✅ **Helper Method: Build a Row with Copy Button**
Widget _buildCopyableRow({required String label, required String value, required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Expanded(
          child: Text(
            '$label ${value.length > 25 ? '${value.substring(0, 22)}...' : value}', // Truncate if too long
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.copy, color: MyColors.color2, size: 20),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: value));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$label copied to clipboard')),
            );
          },
        ),
      ],
    ),
  );
}

/// ✅ **Helper Method: Get Status Color**
Color _getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'finished':
      return Colors.green;
    case 'scheduled':
      return MyColors.color1;
    default:
      return Colors.orange;
  }
}
