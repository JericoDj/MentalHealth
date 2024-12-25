import 'package:flutter/material.dart';

class SpecialistSelection extends StatelessWidget {
  final String? selectedService;
  final Function(String) onSelectService;  // Expecting a String parameter

  const SpecialistSelection({
    Key? key,
    required this.selectedService,
    required this.onSelectService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () async {
          final service = await _showServicePicker(context);
          if (service != null) {
            onSelectService(service);  // Pass the selected service
          }
        },
        child: Text(
          selectedService == null
              ? "Select Service"
              : "$selectedService",
        ),
      ),
    );
  }

  Future<String?> _showServicePicker(BuildContext context) async {
    final List<String> _specialists = [
      "Psychological Assessment",
      "Consultation",
      "Couple Therapy/Counseling",
      "Counseling and Psychotherapy",
    ];

    return showModalBottomSheet<String>(
      context: context,
      builder: (context) => ListView.builder(
        itemCount: _specialists.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_specialists[index]),
          onTap: () {
            Navigator.of(context).pop(_specialists[index]);
          },
        ),
      ),
    );
  }
}
