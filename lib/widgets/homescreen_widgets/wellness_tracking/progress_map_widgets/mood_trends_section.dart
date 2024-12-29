import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:llps_mental_app/widgets/homescreen_widgets/wellness_tracking/progress_map_widgets/mood_trends_widgets/mood_trends_details.dart';

class MoodSection extends StatefulWidget {
  const MoodSection({
    Key? key,
    required List<GlobalKey<State<StatefulWidget>>> sectionKeys,
    String? selectedDay,
  }) : _sectionKeys = sectionKeys, super(key: key);

  final List<GlobalKey<State<StatefulWidget>>> _sectionKeys;

  @override
  State<MoodSection> createState() => _MoodSectionState();
}

class _MoodSectionState extends State<MoodSection> {
  String _selectedPeriod = "Weekly";  // Default to weekly
  final List<String> _periods = ["Weekly", "Monthly", "Quarterly", "Semi-Annual", "Annual"];

  // State variables for selected day and mood
  String _selectedDay = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String _selectedMood = "⬜";

  // Static Mood Data for Specific Dates (Emulates User Input)
  final Map<String, String> _dailyMoodData = {
    "2024-12-01": "🙂",
    "2024-12-02": "😐",
    "2024-12-03": "🙂",
    "2024-12-04": "🌞",
    "2024-12-05": "😢",
    "2024-12-06": "🙂",
    "2024-12-07": "😔",
    "2024-12-08": "😐",
    "2024-12-09": "🙂",
    "2024-12-10": "🌞",
  };

  // Mood Frequency Data for Bar Chart
  final Map<String, Map<String, int>> _moodFrequencyData = {
    "Weekly": {"🌞": 5, "🙂": 3, "😐": 2, "😔": 1, "😢": 1},
    "Monthly": {"🌞": 10, "🙂": 7, "😐": 5, "😔": 3, "😢": 2},
    "Quarterly": {"🌞": 20, "🙂": 15, "😐": 10, "😔": 5, "😢": 3},
    "Semi-Annual": {"🌞": 35, "🙂": 25, "😐": 15, "😔": 7, "😢": 5},
    "Annual": {"🌞": 60, "🙂": 40, "😐": 30, "😔": 15, "😢": 10},
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget._sectionKeys[2],  // Section Key for Scrolling
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          const SizedBox(height: 24),
          _buildDailyMoodRow(),
          const SizedBox(height: 24),
          _buildMoodBarChart(),
          const SizedBox(height: 20),
          SelectedDayDetails(selectedDay: _selectedDay, mood: _selectedMood),
          const Text(
            "Track your emotional patterns over time and identify triggers or trends.",
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // Generate Continuous Dates
  List<Map<String, String>> _generatePastTwoWeeks() {
    List<Map<String, String>> days = [];
    DateTime now = DateTime.now();
    for (int i = 0; i < 30; i++) {
      DateTime day = now.subtract(Duration(days: i));
      String formattedDay = DateFormat('EEE').format(day);  // Mon, Tue, etc.
      String formattedDate = DateFormat('yyyy-MM-dd').format(day);
      days.add({
        "day": formattedDay,
        "date": formattedDate,
        "mood": _dailyMoodData[formattedDate] ?? "⬜"  // Default mood for missing days
      });
    }
    return days.reversed.toList();
  }

  // Horizontal Scrollable Row of Moods
  Widget _buildDailyMoodRow() {
    List<Map<String, String>> days = _generatePastTwoWeeks();

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          final moodEntry = days[index];
          return GestureDetector(
            onTap: () {
              _showMoodDetails(moodEntry["date"]!, moodEntry["mood"]!);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Text(
                    moodEntry["day"]!,
                    style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    moodEntry["mood"]!,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    DateFormat('MMM d').format(DateTime.parse(moodEntry["date"]!)),
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Show Mood Details and Update Selected Day
  void _showMoodDetails(String date, String mood) {
    setState(() {
      _selectedDay = date;
      _selectedMood = mood;
    });
  }
}

// Emoji Bar Chart (Mood Frequency)
Widget _buildMoodBarChart() {
  final moodData = _moodFrequencyData[_selectedPeriod] ?? {"🌞": 0, "🙂": 0, "😐": 0, "😔": 0, "😢": 0};

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: moodData.entries.map((entry) {
      return Column(
        children: [
          Text(
            entry.key,
            style: const TextStyle(fontSize: 26),
          ),
          const SizedBox(height: 8),
          Container(
            height: 100,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: entry.value / 60,  // Dynamic scaling
              child: Container(
                decoration: BoxDecoration(
                  color: _getBarColor(entry.key),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${entry.value}",
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      );
    }).toList(),
  );
}

// Color Based on Mood Emoji
Color _getBarColor(String emoji) {
  switch (emoji) {
    case '🌞':
      return Colors.greenAccent;
    case '🙂':
      return Colors.lightGreen;
    case '😐':
      return Colors.yellow;
    case '😔':
      return Colors.orange;
    case '😢':
      return Colors.redAccent;
    default:
      return Colors.grey;
  }
}

// Mood Frequency Data for Bar Chart
final Map<String, Map<String, int>> _moodFrequencyData = {
  "Weekly": {"🌞": 5, "🙂": 3, "😐": 2, "😔": 1, "😢": 1},
  "Monthly": {"🌞": 10, "🙂": 7, "😐": 5, "😔": 3, "😢": 2},
  "Quarterly": {"🌞": 20, "🙂": 15, "😐": 10, "😔": 5, "😢": 3},
  "Semi-Annual": {"🌞": 35, "🙂": 25, "😐": 15, "😔": 7, "😢": 5},
  "Annual": {"🌞": 60, "🙂": 40, "😐": 30, "😔": 15, "😢": 10},
};

// Default Selected Period for Chart
String _selectedPeriod = "Weekly";  // Can switch between periods via dropdown


