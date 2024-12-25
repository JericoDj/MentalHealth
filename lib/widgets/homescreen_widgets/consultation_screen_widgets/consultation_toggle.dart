import 'package:flutter/material.dart';

class ConsultationToggle extends StatelessWidget {
  final String selectedType;
  final Function(String) onToggle;

  const ConsultationToggle({
    Key? key,
    required this.selectedType,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.5))),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          _buildToggleButton("Online"),
          _buildToggleButton("Face-to-Face"),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String type) {
    final bool isSelected = selectedType == type;
    return Expanded(
      child: TextButton(
        onPressed: () => onToggle(type),
        child: Text(
          type,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.green : Colors.grey,
          ),
        ),
      ),
    );
  }
}
