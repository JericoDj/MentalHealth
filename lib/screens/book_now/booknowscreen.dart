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
                "Welcome to Safe Space",
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
              const SizedBox(height: 10),
              Text(
                "* To book an appointment with a mental health professional, please complete the form below.",
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
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: MyColors.color2, // Header background color
            hintColor: MyColors.color2, // Hint text color
            textTheme: TextTheme(
              headlineMedium: TextStyle( // **Month & Year in header**
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              bodyLarge: const TextStyle( // **Selected Date Text**
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
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
              colorScheme: ColorScheme.light(primary: MyColors.color1),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
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
