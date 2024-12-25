import 'package:flutter/material.dart';
import 'package:llps_mental_app/widgets/homescreen_widgets/consultation_screen_widgets/specialist_selection.dart';

import 'consultation_toggle.dart';
import 'date_time_selection.dart';

class ConsultationForm extends StatelessWidget {
  final String selectedConsultationType;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final String? selectedService;
  final Function() onPickDate;
  final Function() onPickTime;
  final Function(String) onSelectService;  // <-- Accept String here
  final Function(String) onToggleType;

  const ConsultationForm({
    Key? key,
    required this.selectedConsultationType,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedService,
    required this.onPickDate,
    required this.onPickTime,
    required this.onSelectService,  // <-- Updated here
    required this.onToggleType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          ConsultationToggle(
            selectedType: selectedConsultationType,
            onToggle: onToggleType,
          ),
          const SizedBox(height: 30),
          DateTimeSelection(
            selectedDate: selectedDate,
            selectedTime: selectedTime,
            onPickDate: onPickDate,
            onPickTime: onPickTime,
          ),
          const SizedBox(height: 10),
          SpecialistSelection(
            selectedService: selectedService,
            onSelectService: onSelectService,  // Now correct type
          ),
        ],
      ),
    );
  }
}
