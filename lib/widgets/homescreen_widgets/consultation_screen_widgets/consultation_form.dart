import 'package:flutter/material.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';
import 'package:llps_mental_app/widgets/homescreen_widgets/consultation_screen_widgets/specialist_selection.dart';
import 'consultation_toggle.dart';
import 'date_time_selection.dart';

class ConsultationForm extends StatelessWidget {
  final String selectedConsultationType;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final String? selectedService;
  final Function() onPickDate;
  final Function(TimeOfDay) onPickTime;
  final Function(String) onSelectService;
  final Function(String) onToggleType;

  const ConsultationForm({
    Key? key,
    required this.selectedConsultationType,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedService,
    required this.onPickDate,
    required this.onPickTime,
    required this.onSelectService,
    required this.onToggleType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
          // Select Service First


          // Row for Online or Face-to-Face selection
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ConsultationToggle(
                  selectedType: selectedConsultationType,
                  onToggle: onToggleType,
                ),
              ),
            ],
          ),
          const SizedBox(height: 0),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SpecialistSelection(
              selectedService: selectedService,
              onSelectService: onSelectService,
            ),
          ),

          // Select Date
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: GestureDetector(
              onTap: onPickDate,
              child: Container(
                width: 300,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.color2,width: 2),
                  color: MyColors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    selectedDate != null
                        ? "Selected Date: ${selectedDate!.toLocal().toString().split(' ')[0]}"
                        : "Select Date",
                    style: const TextStyle(
                      color: MyColors.color2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),

          // Select Time
          // Select Time
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: GestureDetector(
              onTap: () => onPickTime(TimeOfDay.now()),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.color2,width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    selectedTime != null
                        ? "Selected Time: ${selectedTime!.format(context)}"
                        : "Select Time",
                    style: const TextStyle(
                      color: MyColors.color2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
