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
  String _selectedCategory = "Consultation Touchpoint"; // Default selection
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
  }

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
                      onTap: () => setState(() => _selectedCategory = "Consultation Touchpoint"),
                      child: Container(
                        height: 80,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedCategory == "Consultation Touchpoint" ? MyColors.color2.withValues(alpha: 0.9): Colors.black54,
                          ),
                          color: _selectedCategory == "Consultation Touchpoint" ? MyColors.color2.withValues(alpha: 0.9) : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text(
          
                            "Consultation Touchpoint", textAlign: TextAlign.center, style: TextStyle(
                          fontSize: _selectedCategory == "Consultation Touchpoint" ? 14 : 13,
                            fontWeight: FontWeight.bold,
                            color:  _selectedCategory == "Consultation Touchpoint" ? Colors.white: Colors.black54))),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedCategory = "24/7 Safe Space"),
                      child: Container(
                        height: 80,
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
          
                            fontSize: _selectedCategory == "24/7 Safe Space" ? 15 : 13,
                            fontWeight: FontWeight.bold,
                            color: _selectedCategory == "24/7 Safe Space" ? Colors.white : Colors.black54))),
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
                  : SafeSpaceBody(),
            ],
          ),
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
          : SafeSpaceBottomButtons(onConfirm: _navigateToChatScreen),
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
