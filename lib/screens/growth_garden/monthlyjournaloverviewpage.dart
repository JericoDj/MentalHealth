import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

class MonthlyJournalOverviewPage extends StatefulWidget {
  final DateTime? selectedDate; // Accepts date passed from GratitudeJournalWidget

  const MonthlyJournalOverviewPage({super.key, this.selectedDate});

  @override
  _MonthlyJournalOverviewPageState createState() => _MonthlyJournalOverviewPageState();
}

class _MonthlyJournalOverviewPageState extends State<MonthlyJournalOverviewPage> {
  late DateTime selectedMonth;
  late DateTime currentSelectedDate;

  // Journal Entries (Stored in Memory)
  Map<DateTime, String> journalEntries = {
    DateTime(2025, 2, 2): "Had a great workout today! Feeling strong. 💪",
    DateTime(2025, 2, 58): "Work was stressful, but I managed to stay calm.",
    DateTime(2025, 2,
        14): "Valentine's Day! Spent time with family and felt loved. ❤️",
    DateTime(2025, 2, 21): "Started a new book. Excited to read more!",
    DateTime(2025, 2, 27): "Reflecting on my goals and making progress!",
  }.map((key, value) => MapEntry(_normalizeDate(key), value));

  static DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day); // Remove time component
  }

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.selectedDate ?? DateTime.now();
    currentSelectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(
        selectedMonth.year, selectedMonth.month);
    final firstDay = DateTime(selectedMonth.year, selectedMonth.month, 1);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          toolbarHeight: 65,
          flexibleSpace: Stack(
            children: [


              /// Gradient Bottom Border
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 2, // Border thickness
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange, // Start - Orange
                        Colors.orangeAccent, // Stop 2 - Orange Accent
                        Colors.green, // Stop 3 - Green
                        Colors.greenAccent, // Stop 4 - Green Accent
                      ],
                      stops: const [0.0, 0.5, 0.5, 1.0],
                      // Define stops at 50% transition
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            DateFormat('MMMM y').format(selectedMonth),
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCalendarGrid(context, daysInMonth, firstDay),
              const SizedBox(height: 24),
              _buildJournalHighlights(context),
            ],
          ),
        ),
      ),
    );
  }

  // 📅 Calendar Grid Showing Journal Entries
  Widget _buildCalendarGrid(BuildContext context, int daysInMonth,
      DateTime firstDay) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Journal Calendar', style: GoogleFonts.poppins(
            fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
          ),
          itemCount: daysInMonth + firstDay.weekday - 1,
          itemBuilder: (context, index) {
            if (index < firstDay.weekday - 1) return Container();
            final day = index - firstDay.weekday + 2;
            final date = _normalizeDate(
                DateTime(selectedMonth.year, selectedMonth.month, day));

            return GestureDetector(
              onTap: () => _showJournalEntryPopup(context, date),
              child: CalendarDay(
                day: day,
                hasEntry: journalEntries.containsKey(date),
                isSelected: date ==
                    currentSelectedDate, // Highlight the selected date
              ),
            );
          },
        ),
      ],
    );
  }

  // 📝 Display Journal Highlights
  Widget _buildJournalHighlights(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Journal History', style: GoogleFonts.poppins(
            fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        if (journalEntries.isEmpty)
          const Text("No journal entries this month.",
              style: TextStyle(color: Colors.grey))
        else
          ...journalEntries.entries.map((entry) =>
              GestureDetector(
                onTap: () => _showJournalEntryPopup(context, entry.key),
                child: JournalHighlightCard(
                  date: entry.key,
                  preview: entry.value,
                ),
              )).toList(),
      ],
    );
  }

  // 🔍 Show Journal Entry Popup (With Add & Edit Options)
  void _showJournalEntryPopup(BuildContext context, DateTime date) {
    final bool hasEntry = journalEntries.containsKey(date);
    final String existingEntry = journalEntries[date] ?? "";
    TextEditingController journalController = TextEditingController(text: existingEntry);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Rounded dialog
          titlePadding: const EdgeInsets.all(14),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMMM dd, y').format(date),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Colors.black54, size: 20),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          content: TextField(
            controller: journalController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: hasEntry ? "Edit your journal entry..." : "Write your journal entry...",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)), // Rounded input field
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  if (hasEntry) // Show delete option if an entry exists
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          journalEntries.remove(date);
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.red.withOpacity(0.1),
                        ),
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  const Spacer(), // Pushes buttons apart
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8), // Reduced spacing between buttons
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        journalEntries[date] = journalController.text;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                      decoration: BoxDecoration(
                        color: MyColors.color2,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        hasEntry ? "Save" : "Add",
                        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

}

// 📅 Calendar Day Widget with Journal Indicator (❤️ for entries)
class CalendarDay extends StatelessWidget {
  final int day;
  final bool hasEntry;
  final bool isSelected;

  const CalendarDay({super.key, required this.day, required this.hasEntry, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: isSelected ? MyColors.color2.withOpacity(0.5) : (hasEntry ? MyColors.color2.withValues(alpha: 0.1) : Colors.grey[100]),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: hasEntry ? MyColors.color2 : Colors.grey[300]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$day', style: TextStyle(
            fontWeight: hasEntry ? FontWeight.bold : FontWeight.normal,
            color: hasEntry ? MyColors.color1: Colors.grey,
          )),
          if (hasEntry) const Icon(Icons.favorite, color: Colors.red, size: 18),
        ],
      ),
    );
  }
}

// 📝 Journal Entry Highlights Widget
class JournalHighlightCard extends StatelessWidget {
  final DateTime date;
  final String preview;

  const JournalHighlightCard({super.key, required this.date, required this.preview});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.favorite, color: Colors.red, size: 24), // ❤️ Icon for journal history
            const SizedBox(width: 16),
            Expanded(
              child: Text(preview, style: GoogleFonts.poppins(), maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}