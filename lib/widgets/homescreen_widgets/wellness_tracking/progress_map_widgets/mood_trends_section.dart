import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MoodSection extends StatefulWidget {
  const MoodSection({
    Key? key,
    required List<GlobalKey<State<StatefulWidget>>> sectionKeys,
  }) : _sectionKeys = sectionKeys, super(key: key);

  final List<GlobalKey<State<StatefulWidget>>> _sectionKeys;

  @override
  State<MoodSection> createState() => _MoodSectionState();
}

class _MoodSectionState extends State<MoodSection> {
  String _selectedPeriod = "Weekly";  // Default to weekly
  final List<String> _periods = ["Weekly", "Monthly", "Quarterly", "Semi-Annual", "Annual"];

  // Example Mood Data (Y-Axis Values)
  final List<int> _weeklyMoodData = [3, 5, 4, 2, 6, 5, 3]; // 1-6 scale (e.g., 1 = bad, 6 = great)

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget._sectionKeys[2],
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row with Dropdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Mood Trends",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              DropdownButton<String>(
                value: _selectedPeriod,
                dropdownColor: Colors.orange,
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
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Mood Bar Graph
          _buildMoodGraph(),

          const SizedBox(height: 10),
          const Text(
            "Track your emotional patterns over time and identify triggers or patterns.",
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // Bar Graph Widget (Weekly Example)
  Widget _buildMoodGraph() {
    return AspectRatio(
      aspectRatio: 2, // Adjust height of the graph
      child: BarChart(
        BarChartData(
          barGroups: _buildBarGroups(),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, interval: 1, reservedSize: 30),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(days[value.toInt()], style: const TextStyle(color: Colors.white)),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: true),
        ),
      ),
    );
  }

  // Mood Data for Bar Graph (X-Axis)
  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(_weeklyMoodData.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: _weeklyMoodData[index].toDouble(),
            color: _getBarColor(_weeklyMoodData[index]),
            width: 18,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      );
    });
  }

  // Color Based on Mood
  Color _getBarColor(int moodScore) {
    if (moodScore >= 5) {
      return Colors.greenAccent; // Positive Mood
    } else if (moodScore >= 3) {
      return Colors.yellowAccent; // Neutral Mood
    } else {
      return Colors.redAccent; // Negative Mood
    }
  }
}
