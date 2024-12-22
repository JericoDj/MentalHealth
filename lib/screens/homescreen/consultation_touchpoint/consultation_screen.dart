import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../widgets/homescreen_widgets/call_customer_support_widget.dart';
import '../booking_review_screen.dart';
import '../../../widgets/accounts_screen/consultation_status_widget.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({Key? key}) : super(key: key);

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  String _selectedConsultationType = "Online";  // Default to Online
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedSpecialist;
  int availableCredits = 5;

  final List<String> _specialists = [
    "Dr. John Doe",
    "Dr. Jane Smith",
    "Dr. Alex Brown"
  ];

  void _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  void _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  void _showSpecialistPicker() async {
    final specialist = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => ListView.builder(
        itemCount: _specialists.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_specialists[index]),
          onTap: () => Navigator.of(context).pop(_specialists[index]),
        ),
      ),
    );
    if (specialist != null) {
      setState(() => _selectedSpecialist = specialist);
    }
  }

  void _showCustomerSupportPopup() {
    showDialog(
      context: context,
      builder: (context) => CallCustomerSupportPopup(),
    );
  }

  Widget _buildConsultationForm() {
    String _formatDate(DateTime date) =>
        DateFormat('EEE., MMM. d').format(date);
    String _formatTime(TimeOfDay time) {
      final now = DateTime.now();
      final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
      return DateFormat('h:mm a').format(dt);
    }

    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(.2)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // AppBar-like Consultation Type Toggle
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.5)))),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                _buildToggleTextButton("Online"),
                _buildToggleTextButton("Face-to-Face"),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Date and Time Selection
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pickDate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent.withOpacity(0.3),
                    ),
                    child: Text(
                      _selectedDate == null
                          ? "Select Date"
                          : _formatDate(_selectedDate!),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pickTime,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent.withOpacity(0.3),
                    ),
                    child: Text(
                      _selectedTime == null
                          ? "Select Time"
                          : _formatTime(_selectedTime!),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Specialist Selection
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ElevatedButton(
              onPressed: _showSpecialistPicker,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent.withOpacity(0.3),
              ),
              child: Text(
                _selectedSpecialist == null
                    ? "Select Specialist"
                    : "Specialist: $_selectedSpecialist",
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleTextButton(String type) {
    final bool isSelected = _selectedConsultationType == type;
    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            _selectedConsultationType = type;
          });
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
        ),
        child: Text(
          type,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.green : Colors.grey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consultation Touchpoint"),
        backgroundColor: Colors.greenAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildConsultationForm(),
            const SizedBox(height: 20),

            // Available credits
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.greenAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Available Credits: $availableCredits",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _showCustomerSupportPopup,
              child: const Text(
                "Call Customer Support",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.redAccent,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: availableCredits > 0 &&
                    _selectedDate != null &&
                    _selectedTime != null &&
                    _selectedSpecialist != null
                    ? () {
                  Get.to(() => BookingReviewScreen(
                    consultationType: _selectedConsultationType,
                    selectedDate: DateFormat('EEE., MMM. d').format(_selectedDate!),
                    selectedTime: _selectedTime!.format(context),
                    specialist: _selectedSpecialist!,
                  ));
                } : null,
                child: const Text("Book A Session"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
