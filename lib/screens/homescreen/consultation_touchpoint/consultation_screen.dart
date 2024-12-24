import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  final List<String> _specialists = [
    "Psychological Assessment",
    "Consultation",
    "Couple Therapy/Counseling",
    "Counseling and Psychotherapy",
  ];

  final Map<String, String> _serviceDetails = {
    "Psychological Assessment":
    "Use of integrative tools such as testing, interviews, observation, or other assessment tools for a "
        "comprehensive understanding of a client’s system, concern, or condition depending on their needs and "
        "purpose (e.g. school, employment, diagnosis, legal requirement, emotional support animal).",

    "Consultation":
    "A session where you can freely express, share, and consult your mental health concerns, experiences, "
        "thoughts, and emotions. A recommendation or established therapeutic goals will be provided at the end of this "
        "session.\n\n"
        "A. Psychiatric Consultation – A consultation with a psychiatrist.\n"
        "B. Adult Psychological Consultation – A session for adults with a psychologist.\n"
        "C. Child and Adolescent Psychological Consultation – A session for children and adolescents with a psychologist.",

    "Couple Therapy/Counseling":
    "An intervention aimed at helping couples build healthy relationships and facilitate conflict resolution "
        "to overcome issues that hinder a satisfying relationship.",

    "Counseling and Psychotherapy":
    "A therapeutic session with a psychologist to assist a client towards healing, intervention, or recovery from "
        "their concerns, experiences, trauma, or any psychological and mental health challenges."
  };

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
  void _showSpecialistPicker() async {
    final service = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => ListView.builder(
        itemCount: _specialists.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_specialists[index]),
          trailing: IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.blue),
            onPressed: () {
              Navigator.of(context).pop();
              _showServiceDetails(_specialists[index]);
            },
          ),
          onTap: () {
            Navigator.of(context).pop(_specialists[index]);
          },
        ),
      ),
    );
    if (service != null) {
      setState(() {
        _selectedService = service;
      });
    }
  }

  // Show Service Details
  void _showServiceDetails(String service) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(service),
          content: Text(_serviceDetails[service] ?? "No description available."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  // Customer Support Popup
  void _showCustomerSupportPopup() {
    showDialog(
      context: context,
      builder: (context) =>CallCustomerSupportPopup(),
    );
  }

  // Build Consultation Form
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
          // Consultation Type Toggle
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.5))),
            ),
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
          _buildDateTimeSelection(_formatDate, _formatTime),

          const SizedBox(height: 10),

          // Specialist Selection
          _buildSpecialistSelection(),
        ],
      ),
    );
  }

  Widget _buildDateTimeSelection(_formatDate, _formatTime) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: _pickDate,
              child: Text(
                _selectedDate == null
                    ? "Select Date"
                    : _formatDate(_selectedDate!),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              onPressed: _pickTime,
              child: Text(
                _selectedTime == null
                    ? "Select Time"
                    : _formatTime(_selectedTime!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialistSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: _showSpecialistPicker,
        child: Text(
          _selectedService == null
              ? "Select Service"
              : "Service: $_selectedService",
        ),
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
        child: Text(
          type,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.green : Colors.grey,
          ),
        ),
      ),
    );
  }

  // **Build Method (Required for the State Class)**
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
                    _selectedService != null
                    ? () {
                  Get.to(() => BookingReviewScreen(
                    consultationType: _selectedConsultationType,
                    selectedDate: DateFormat('EEE., MMM. d').format(_selectedDate!),
                    selectedTime: _selectedTime!.format(context),
                    service: _selectedService!,
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
