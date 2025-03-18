import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

import '../../controllers/session_controller.dart';
import '../../widgets/homescreen_widgets/call_customer_support_widget.dart';
import '../../widgets/homescreen_widgets/consultation_screen_widgets/bottom_buttons.dart';
import '../../widgets/homescreen_widgets/consultation_screen_widgets/consultation_form.dart';
import '../homescreen/booking_review_screen.dart';

class BookNowScreen extends StatefulWidget {
  const BookNowScreen({Key? key}) : super(key: key);

  @override
  State<BookNowScreen> createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  String _selectedConsultationType = "Online"; // Default consultation type
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedService;

  // Access SessionController to get session data
  late SessionController sessionController;

  @override
  void initState() {
    super.initState();
    sessionController = Get.find<SessionController>(); // Initialize controller

    // Show welcome dialog when the screen loads
    Future.delayed(Duration.zero, () {
      _showWelcomeDialog();
    });
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      barrierDismissible: true, // Allow dismissing by tapping outside
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Make dialog wrap content
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome to Consultation Touchpoint",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: MyColors.color1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                "Connect with a mental health specialist or professional for support.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
                textAlign: TextAlign.center,
              ),


              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                  decoration: BoxDecoration(
                    color: MyColors.color2, // Custom button color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Okay",
                      style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickDate() async {
    DateTime today = DateTime.now();
    DateTime firstSelectableDate = today.add(const Duration(days: 2)); // Allow selection only from 2 days ahead
    DateTime lastSelectableDate = firstSelectableDate.add(const Duration(days: 365)); // Allow up to 1 year from then

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: firstSelectableDate, // Default to 2 days from now
      firstDate: firstSelectableDate, // Prevent selection of today or tomorrow
      lastDate: lastSelectableDate, // Limit selection up to 1 year from then
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: MyColors.color2, // Header background color
            hintColor: MyColors.color2, // Hint text color
            textTheme: const TextTheme(
              headlineMedium: TextStyle( // **Month & Year in header**
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              bodyLarge: TextStyle( // **Selected Date Text**
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            colorScheme: ColorScheme.light(
              primary: MyColors.color2, // Selected date color
              onPrimary: Colors.white70, // Selected date text color
              onSurface: MyColors.color1, // Normal text color
            ),
            dialogBackgroundColor: Colors.white, // Background color
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate; // Update selected date
      });
    }
  }

  void _pickTime(TimeOfDay time) {
    setState(() {
      _selectedTime = time;
    });
  }

  void _bookSession() {
    if (_selectedDate != null && _selectedTime != null && _selectedService != null) {
      Get.to(() => BookingReviewScreen(
        consultationType: _selectedConsultationType,
        selectedDate: DateFormat('EEE, MMM d').format(_selectedDate!),
        selectedTime: _selectedTime!.format(context),
        service: _selectedService!,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isFormComplete = _selectedDate != null && _selectedTime != null && _selectedService != null;

    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Consultation Form
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomButtons(
        isFormComplete: isFormComplete,
        onBookSession: _bookSession,
        onCallSupport: () => showDialog(
          context: context,
          builder: (context) => CallCustomerSupportPopup(),
        ),
      ),
    );
  }
}
