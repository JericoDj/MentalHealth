import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StressLevelSection extends StatefulWidget {
  const StressLevelSection({
    Key? key,
    required List<GlobalKey<State<StatefulWidget>>> sectionKeys,
  }) : _sectionKeys = sectionKeys, super(key: key);

  final List<GlobalKey<State<StatefulWidget>>> _sectionKeys;

  @override
  State<StressLevelSection> createState() => _StressLevelSectionState();
}

class _StressLevelSectionState extends State<StressLevelSection> {
  String _selectedPeriod = "Daily"; // Default
  final List<String> _periods = ["Daily", "Weekly", "Monthly", "Quarterly", "Semi-Annual", "Annual"];

  // Sample Stress Data (Example % Distribution)
  Map<String, double> _stressData = {
    "Low": 40,
    "Moderate": 35,
    "High": 25,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget._sectionKeys[3],
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title and Dropdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Stress Level Management",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              DropdownButton<String>(
                value: _selectedPeriod,
                dropdownColor: Colors.red,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                underline: Container(height: 1, color: Colors.white),
                items: _periods.map((String period) {
                  return DropdownMenuItem(
                    value: period,
                    child: Text(period),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPeriod = value!;
                    _updateStressData();  // Update data when period changes
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Pie Chart Display
          _buildPieChart(),

          const SizedBox(height: 20),

          // Recommendation Section
          _buildRecommendations(),
        ],
      ),
    );
  }

  // Pie Chart Widget
  Widget _buildPieChart() {
    return AspectRatio(
      aspectRatio: 1.5,
      child: PieChart(
        PieChartData(
          sections: _buildPieChartSections(),
          centerSpaceRadius: 40,
          sectionsSpace: 2,
        ),
      ),
    );
  }

  // Pie Chart Data (Color and Values)
  List<PieChartSectionData> _buildPieChartSections() {
    return _stressData.entries.map((entry) {
      final isTouched = entry.value > 30;  // Highlight sections with high percentage
      final color = _getSectionColor(entry.key);

      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: '${entry.value.toInt()}%',
        radius: isTouched ? 60 : 50,
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();
  }

  // Get Colors Based on Stress Level
  Color _getSectionColor(String level) {
    switch (level) {
      case "Low":
        return Colors.greenAccent;
      case "Moderate":
        return Colors.yellowAccent;
      case "High":
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  // Recommendations Based on Dominant Stress Level
  Widget _buildRecommendations() {
    String recommendation = "You're doing great! Keep practicing mindfulness.";

    if (_stressData["High"]! > 30) {
      recommendation = "Your stress is high. Consider relaxation techniques or counseling.";
    } else if (_stressData["Moderate"]! > 40) {
      recommendation = "Moderate stress detected. Try incorporating breaks and physical activity.";
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              recommendation,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  // Simulate Data Update Based on Time Period
  void _updateStressData() {
    setState(() {
      switch (_selectedPeriod) {
        case "Weekly":
          _stressData = {"Low": 50, "Moderate": 30, "High": 20};
          break;
        case "Monthly":
          _stressData = {"Low": 35, "Moderate": 40, "High": 25};
          break;
        case "Annual":
          _stressData = {"Low": 60, "Moderate": 25, "High": 15};
          break;
        default:
          _stressData = {"Low": 40, "Moderate": 35, "High": 25};
      }
    });
  }
}
