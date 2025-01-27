import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../widgets/homescreen_widgets/consultation_screen_widgets/consultation_form.dart';
import '../../../widgets/homescreen_widgets/consultation_screen_widgets/bottom_buttons.dart';
import '../../../widgets/homescreen_widgets/call_customer_support_widget.dart';
import '../booking_review_screen.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({Key? key}) : super(key: key);

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  String _selectedConsultationType = "Online";  // Default to Online
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedService;
  int availableCredits = 5;

  // Pick Date
  void _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  // Pick Time
  void _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  // Show Specialist Picker

  // Service Options
  final Map<String, String> _specialists = {
    "Psychological Assessment":
    "Comprehensive assessment through interviews and tests.",
    "Consultation":
    "General consultation to address mental health concerns.",
    "Couple Therapy/Counseling":
    "Help couples resolve conflicts and improve relationships.",
    "Counseling and Psychotherapy":
    "Therapy sessions aimed at healing and mental well-being.",
  };

  // Customer Support Popup
  void _showCustomerSupportPopup() {
    showDialog(
      context: context,
      builder: (context) => CallCustomerSupportPopup(),
    );
  }

  // Book Session
  void _bookSession() {
    if (_selectedDate != null && _selectedTime != null && _selectedService != null) {
      Get.to(() => BookingReviewScreen(
        consultationType: _selectedConsultationType,
        selectedDate: DateFormat('EEE., MMM. d').format(_selectedDate!),
        selectedTime: _selectedTime!.format(context),
        service: _selectedService!,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isFormComplete = _selectedDate != null &&
        _selectedTime != null &&
        _selectedService != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Consultation Touchpoint"),
        backgroundColor: Colors.greenAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ConsultationForm(
              selectedConsultationType: _selectedConsultationType,
              selectedDate: _selectedDate,
              selectedTime: _selectedTime,
              selectedService: _selectedService,
              onPickDate: _pickDate,
              onPickTime: _pickTime,
              onSelectService: (String service) {
                setState(() {
                  _selectedService = service;
                });
              },
              onToggleType: (type) {
                setState(() {
                  _selectedConsultationType = type;
                });
              },
            ),
            const SizedBox(height: 30),
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
          ],
        ),
      ),
      bottomNavigationBar:


      BottomButtons(


        isFormComplete: isFormComplete,
        onBookSession: _bookSession,
        onCallSupport: _showCustomerSupportPopup,
      ),
    );
  }
}
