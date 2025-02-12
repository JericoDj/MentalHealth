import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

import '../../controllers/session_controller.dart';
import '../../widgets/homescreen_widgets/call_customer_support_widget.dart';
import '../../widgets/homescreen_widgets/consultation_screen_widgets/bottom_buttons.dart';
import '../../widgets/homescreen_widgets/consultation_screen_widgets/consultation_form.dart';
import '../../widgets/homescreen_widgets/safe_space/safe_space_bottom_buttons.dart';
import '../homescreen/booking_review_screen.dart';
import '../homescreen/safe_space/queue_screen.dart';
import '../homescreen/safe_space/safe_space.dart';
class BookNowScreen extends StatefulWidget {
  const BookNowScreen({Key? key}) : super(key: key);

  @override
  State<BookNowScreen> createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  String _selectedCategory = "Safe Space"; // Default selection
  String _selectedConsultationType = "Online"; // Default to Online
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedService;

  // Access SessionController to get session data
  late SessionController sessionController;

  @override
  void initState() {
    super.initState();
    sessionController = Get.find<SessionController>(); // Initialize the controller

    // Show welcome dialog when the screen loads
    Future.delayed(Duration.zero, () {
      _showWelcomeDialog();
    });
  }


  void _showWelcomeDialog() {
    showDialog(
      context: context,
      barrierDismissible: true, // Allows the user to tap outside to dismiss
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Makes the dialog wrap its content
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
                textAlign: TextAlign.center
                ,
              ),
              const SizedBox(height: 10),
              Text(
                "* To book an appointment with a mental health professional, please complete the form through this link",
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
              headlineMedium: TextStyle( // **Month & Year in the header**
                fontSize: 20, // Bigger text
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),

              bodyLarge: const TextStyle( // **Selected Date Text**
                fontSize: 16, // Bigger for emphasis
                fontWeight: FontWeight.bold,
                color: Colors.black, // Black text for selected date
              ),
            ),
            colorScheme: ColorScheme.light(
              primary: MyColors.color2, // Selected date color
              onPrimary: Colors.white70, // Selected date text (black)
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




  // Pick Time
  void _pickTime(TimeOfDay time) {
    setState(() {
      _selectedTime = time;
    });
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          
              SizedBox(height: 20,),
              // Category Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedCategory = "Safe Space"),
                      child: Container(
                        height: 86,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedCategory == "Safe Space" ? MyColors.color2.withValues(alpha: 0.9): Colors.black54,
                          ),
                          color: _selectedCategory == "Safe Space" ? MyColors.color2.withValues(alpha: 0.9) : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text(
          
                            "Safe Space", textAlign: TextAlign.center, style: TextStyle(
                          fontSize: _selectedCategory == "Safe Space" ? 16 : 14,
                            fontWeight: FontWeight.bold,
                            color:  _selectedCategory == "Safe Space" ? Colors.white: Colors.black54))),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedCategory = "24/7 Safe Space"),
                      child: Container(
                        height: 86,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedCategory == "24/7 Safe Space" ? MyColors.color2.withValues(alpha: 0.9): Colors.black54,
                          ),
                          color: _selectedCategory == "24/7 Safe Space" ? MyColors.color2.withValues(alpha: 0.9): Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text(
          
                            "24/7 Safe Space", style: TextStyle(
          
                            fontSize: _selectedCategory == "24/7 Safe Space" ? 16 : 14,
                            fontWeight: FontWeight.bold,
                            color: _selectedCategory == "24/7 Safe Space" ? Colors.white : Colors.black54))),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
          
              // Dynamic Content
              _selectedCategory == "Safe Space"
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
                  : SafeSpaceBody(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _selectedCategory == "Safe Space"
          ? BottomButtons(
        isFormComplete: isFormComplete,
        onBookSession: _bookSession,
        onCallSupport: () => showDialog(
          context: context,
          builder: (context) => CallCustomerSupportPopup(),
        ),
      )
          : SafeSpaceBottomButtons(onConfirm: _navigateToChatScreen, onCallSupport: () => showDialog(
        context: context,
        builder: (context) => CallCustomerSupportPopup(),
      ),

      ),
    );
  }

  // Navigate to chat screen for 24/7 Safe Space
  void _navigateToChatScreen() {
    // Get session type and action from the controller
    String? selectedSessionType = sessionController.selectedSessionType?.value;
    String? selectedAction = sessionController.selectedAction?.value;

    if (selectedSessionType != null && selectedAction != null) {
      Get.to(() => QueueScreen(sessionType: selectedSessionType));
    } else {
      Get.snackbar(
        'Incomplete',
        'Please select a session type and action.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
