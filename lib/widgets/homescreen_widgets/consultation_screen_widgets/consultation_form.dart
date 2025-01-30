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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: MyColors.color2.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                textAlign: TextAlign.center,
                "Book a session with a specialist at your convenience. We're ready to assist you when needed.",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFfcbc1d),
                Color(0xFFfd9c33),
                Color(0xFF59b34d),
                Color(0xFF359d4e),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
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
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: onPickDate,
                        child: Container(
                          height: 50,
                          width: 140,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedDate == null ? Colors.grey : MyColors.color2,
                              width: 2,
                            ),
                            color: selectedDate == null ? Colors.white : MyColors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              selectedDate != null
                                  ? "${selectedDate!.toLocal().toString().split(' ')[0]}"
                                  : "Select Date",
                              style: TextStyle(
                                color: selectedDate == null ? Colors.black87.withAlpha(180) : MyColors.color2,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () => _showTimePicker(context),
                        child: Container(
                          height: 50,
                          width: 140,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedTime == null ? Colors.grey : MyColors.color2,
                              width: 2,
                            ),
                            color: selectedTime == null ? Colors.white : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              selectedTime != null
                                  ? "${selectedTime!.format(context)}"
                                  : "Select Time",
                              style: TextStyle(
                                color: selectedTime == null ? Colors.black87.withAlpha(180) : MyColors.color2,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showTimePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              final time = TimeOfDay(hour: 8 + index, minute: 0);
              return ListTile(
                title: Text(time.format(context)),
                onTap: () {
                  onPickTime(time);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
}