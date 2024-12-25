import 'package:flutter/material.dart';

class SpecialistSelection extends StatelessWidget {
  final String? selectedService;
  final Function(String) onSelectService;

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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedService ?? "Select Service",
            ),
            if (selectedService != null) ...[
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  _showServiceDetails(
                    context,
                    selectedService!,
                    _getServiceDescription(selectedService!),
                  );
                },
                child: Tooltip(
                  message: "Show details",
                  child: const Icon(Icons.info_outline, color: Colors.blue, size: 18),
                ),
              ),
            ],
          ],
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
          title: Row(
            children: [
              Text(_specialists[index]),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  _showServiceDetails(
                    context,
                    _specialists[index],
                    _getServiceDescription(_specialists[index]),
                  );
                },
                child: Tooltip(
                  message: "Show details",
                  child: const Icon(Icons.info_outline, color: Colors.blue, size: 18),
                ),
              ),
            ],
          ),
          onTap: () => Navigator.of(context).pop(_specialists[index]),
        ),
      ),
    );
  }

  String _getServiceDescription(String service) {
    const Map<String, String> _serviceDetails = {
      "Psychological Assessment":
      "Comprehensive tools like tests, interviews, and observations to understand mental health for school, work, legal, or personal purposes.",

      "Consultation":
      "Discuss mental health concerns with a psychologist or psychiatrist. Get guidance and therapeutic goals.\n\n"
          "A. Psychiatric Consultation – With a psychiatrist.\n"
          "B. Adult Psychological Consultation – For adults.\n"
          "C. Child and Adolescent Consultation – For children and teens.",

      "Couple Therapy/Counseling":
      "Helps couples build healthy relationships and resolve conflicts that hinder satisfaction.",

      "Counseling and Psychotherapy":
      "Therapy for emotional healing, trauma, and mental health challenges with a psychologist.",
    };

    return _serviceDetails[service] ?? "No description available.";
  }

  void _showServiceDetails(BuildContext context, String service, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(service),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}
