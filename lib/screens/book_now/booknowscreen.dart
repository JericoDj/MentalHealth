import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';
import '../../../widgets/homescreen_widgets/consultation_screen_widgets/consultation_form.dart';
import '../../../widgets/homescreen_widgets/consultation_screen_widgets/bottom_buttons.dart';
import '../../../widgets/homescreen_widgets/call_customer_support_widget.dart';
import '../homescreen/booking_review_screen.dart';

class BookNowScreen extends StatefulWidget {
  const BookNowScreen({Key? key}) : super(key: key);

  @override
  State<BookNowScreen> createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  String _selectedCategory = "Consultation Touchpoint"; // Default selection
  String _selectedConsultationType = "Online"; // Default to Online
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedService;

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
    bool isFormComplete = _selectedDate != null && _selectedTime != null && _selectedService != null;

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedCategory = "Consultation Touchpoint"),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _selectedCategory == "Consultation Touchpoint" ? Colors.blueAccent : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(child: Text("Consultation Touchpoint", style: TextStyle(color: Colors.white))),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedCategory = "24/7 Safe Space"),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _selectedCategory == "24/7 Safe Space" ? Colors.blueAccent : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(child: Text("24/7 Safe Space", style: TextStyle(color: Colors.white))),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Dynamic Content
            _selectedCategory == "Consultation Touchpoint"
                ? ConsultationForm(
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
            )
                : Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purpleAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome to 24/7 Safe Space!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 10),
                  Text(
                    "Our 24/7 Safe Space provides immediate support and mental wellness resources whenever you need them. No need to book—just connect!",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _selectedCategory == "Consultation Touchpoint"
          ? BottomButtons(
        isFormComplete: isFormComplete,
        onBookSession: _bookSession,
        onCallSupport: () => showDialog(
          context: context,
          builder: (context) => CallCustomerSupportPopup(),
        ),
      )
          : null, // No booking buttons for 24/7 Safe Space
    );
  }
}