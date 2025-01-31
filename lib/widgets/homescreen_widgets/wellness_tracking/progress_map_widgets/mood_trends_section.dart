import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';
import 'package:llps_mental_app/widgets/homescreen_widgets/wellness_tracking/progress_map_widgets/mood_trends_widgets/mood_trends_details.dart';

class MoodSection extends StatefulWidget {
  const MoodSection({
    Key? key,
    required List<GlobalKey<State<StatefulWidget>>> sectionKeys,
    this.selectedDay, // ✅ Now accepts selectedDay
  }) : _sectionKeys = sectionKeys, super(key: key);

  final List<GlobalKey<State<StatefulWidget>>> _sectionKeys;
  final String? selectedDay;

  @override
  State<MoodSection> createState() => _MoodSectionState();
}

class _MoodSectionState extends State<MoodSection> {
  String _selectedPeriod = "Weekly";
  final List<String> _periods = ["Weekly", "Monthly", "Quarterly", "Semi-Annual", "Annual"];
  late String _selectedDay;
  String _selectedMood = "⬜";

  final Map<String, String> _dailyMoodData = {
    "2024-12-01": "🙂",
    "2024-12-02": "😐",
    "2024-12-03": "🙂",
    "2024-12-04": "🌞",
    "2024-12-05": "😢",
  };

  final Map<String, Map<String, int>> _moodFrequencyData = {
    "Weekly": {"🌞": 5, "🙂": 3, "😐": 2, "😔": 1, "😢": 1},
    "Monthly": {"🌞": 10, "🙂": 7, "😐": 5, "😔": 3, "😢": 2},
    "Quarterly": {"🌞": 20, "🙂": 15, "😐": 10, "😔": 5, "😢": 3},
    "Semi-Annual": {"🌞": 35, "🙂": 25, "😐": 15, "😔": 7, "😢": 5},
    "Annual": {"🌞": 60, "🙂": 40, "😐": 30, "😔": 15, "😢": 10},
  };

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDay ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
    _selectedMood = _dailyMoodData[_selectedDay] ?? "⬜";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget._sectionKeys[2],
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            Color(0xFFfcbc1d),
            Color(0xFFfd9c33),
            Color(0xFF59b34d),
            Color(0xFF359d4e),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Mood Trends",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                DropdownButton<String>(
                  value: _selectedPeriod,
                  dropdownColor: Colors.white,
                  style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                  underline: Container(height: 1, color: Colors.black87),
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

            SelectedDayDetails(
              selectedDay: _selectedDay,
              mood: _selectedMood,
            ),
            const Text(
              "Track your emotional patterns over time and identify triggers or trends.",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  // Generate Mood Data for Past X Days
  List<Map<String, String>> _generatePastDays({int daysCount = 14}) {
    List<Map<String, String>> days = [];
    DateTime now = DateTime.now();
    for (int i = 0; i < daysCount; i++) {
      DateTime day = now.subtract(Duration(days: i));
      String formattedDay = DateFormat('EEE').format(day); // Mon, Tue, etc.
      String formattedDate = DateFormat('yyyy-MM-dd').format(day);
      days.add({
        "day": formattedDay,
        "date": formattedDate,
        "mood": _dailyMoodData[formattedDate] ?? "⬜"
      });
    }
    return days.reversed.toList();
  }

  // Horizontal Scrollable Mood History
  Widget _buildDailyMoodRow() {
    List<Map<String, String>> days = _generatePastDays();

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
                    style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    moodEntry["mood"]!,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    DateFormat('MMM d').format(DateTime.parse(moodEntry["date"]!)),
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Mood Frequency Chart
  Widget _buildMoodBarChart() {
    final moodData = _moodFrequencyData[_selectedPeriod] ?? {"🌞": 0, "🙂": 0, "😐": 0, "😔": 0, "😢": 0};

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: moodData.entries.map((entry) {
        return Column(
          children: [
            Text(entry.key, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 8),
            Container(
              height: 100,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: entry.value / 60, // Scaling
                child: Container(
                  decoration: BoxDecoration(
                    color: _getBarColor(entry.key),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text("${entry.value}", style: const TextStyle(fontSize: 16, color: Colors.white)),
          ],
        );
      }).toList(),
    );
  }

  // Mood Color Mapping
  Color _getBarColor(String emoji) {
    return {"🌞": Colors.greenAccent, "🙂": Colors.lightGreen, "😐": Colors.yellow, "😔": Colors.orange, "😢": Colors.redAccent}[emoji] ?? Colors.grey;
  }

  void _showMoodDetails(String date, String mood) {
    setState(() {
      _selectedDay = date;
      _selectedMood = mood;
      print("Selected Day: $_selectedDay, Mood: $_selectedMood"); // Debugging
    });}}