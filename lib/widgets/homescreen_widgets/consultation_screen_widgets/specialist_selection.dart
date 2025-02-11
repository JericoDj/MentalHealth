import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
        onTap: () async {
          final service = await _showServicePicker(context);
          if (service != null) {
            onSelectService(service);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: selectedService == null
                  ? [Colors.black45, Colors.black54] // Black gradient when no service is selected
                  : [MyColors.color1, MyColors.color2], // Custom gradient when service is selected
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(2), // Creates the gradient border effect
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedService ?? "Select Service",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: selectedService == null
                        ? Colors.black45.withAlpha(180) // Faded text when not selected
                        : Colors.black87,
                  ),
                ),
                if (selectedService != null) ...[
                  const SizedBox(width: 8),
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
                      child: const Icon(Icons.info_outline, color: MyColors.color1, size: 22),
                    ),
                  ),
                ],
              ],
            ),
          ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView.builder(
          itemCount: _specialists.length,
          itemBuilder: (context, index) => Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                _specialists[index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: GestureDetector(
                onTap: () {
                  _showServiceDetails(
                    context,
                    _specialists[index],
                    _getServiceDescription(_specialists[index]),
                  );
                },
                child: Tooltip(
                  message: "Show details",
                  child: const Icon(Icons.info_outline, color: MyColors.color1, size: 18),
                ),
              ),
              onTap: () => Navigator.of(context).pop(_specialists[index]),
            ),
          ),
        ),
      ),
    );
  }

  String _getServiceDescription(String service) {
    const Map<String, String> _serviceDetails = {
      "Psychological Assessment":
      "Use of integrative tools such as testing, interviews, and observation, or other assessment tools to a comprehensive understanding of the client's system, concern or condition depending on their needs and purpose(e.g. school, employment, diagnosis, legal requirement, emotional support animal)",
      "Consultation":
      "A session where you can freely express, share, and consult your mental health concerns, experiences, thoughts and emotions. A recommendation or established therapeutic goals will be given at the end of this session.\n\n"
          "A. Psychiatric Consultation – With a psychiatrist.\n"
          "B. Adult Psychological Consultation – For adults.\n"
          "C. Child and Adolescent Consultation – For children and teens.",
      "Couple Therapy/Counseling":
      "An intervention that aims to help the couple build a healthy relationship and facilitate conflict resolutions that hinder a satisfying relationship",
      "Counseling and Psychotherapy":
      "A therapeutic session with a psychologist to help a client towards healing, intervention, or recovery from his/her concern, experiences, trauma, or any psychological and mental health challenges.",
    };

    return _serviceDetails[service] ?? "No description available.";
  }

  void _showServiceDetails(BuildContext context, String service, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          service,
          style: TextStyle(color: MyColors.color1, fontWeight: FontWeight.bold),
        ),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Close", style: TextStyle(color: MyColors.color1,fontSize: 14, )),
          ),
        ],
      ),
    );
  }
}
