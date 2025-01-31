import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/constants/colors.dart';
import '../monthlyjournaloverviewpage.dart';

class GratitudeJournalWidget extends StatefulWidget {
  @override
  _GratitudeJournalWidgetState createState() => _GratitudeJournalWidgetState();
}

class _GratitudeJournalWidgetState extends State<GratitudeJournalWidget> {
  Map<String, List<String>> journalEntries = {};
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime selectedMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Add static data to journalEntries
    _addStaticData();
  }

  void _addStaticData() {
    journalEntries = {
      '2025-02-02': [
        'I am grateful for my family.',
        'I am grateful for good health.',
      ],
      '2025-02-01': [
        'I am grateful for the beautiful weather.',
        'I am grateful for my friends.',
      ],
      '2025-01-02': [
        'I am grateful for my job.',
        'I am grateful for my pets.',
      ],
      '2025-02-04': [
        'I am grateful for new opportunities.',
        'I am grateful for my creativity.',
      ],
      '2025-02-15': [
        'I am grateful for my hobbies.',
        'I am grateful for my home.',
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            MyColors.color1,
            Colors.green,
            Colors.orange,
            MyColors.color2
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            _headerSection(),
            const Divider(height: 1, color: Colors.black38),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _journalListView(),
                  _buildAddEntryButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerSection() {
    return Container(
      decoration: BoxDecoration(color: Colors.white12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Gratitude Journal',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: MyColors.color1,
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => MonthlyJournalOverviewPage());
                  },
                  child: const Icon(
                      Icons.calendar_today, size: 18, color: MyColors.color1),
                ),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: () =>

                      selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: MyColors.color1,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          DateFormat('MMM d, yyyy').format(DateTime.parse(
                              currentDate)),
                          style: const TextStyle(color: Colors.white,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _journalListView() {
    List<String> entries = journalEntries[currentDate] ?? [];
    if (entries.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'No entries for today.',
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entries.length,
      itemBuilder: (context, index) =>
          Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              return await _showDeleteDialog(context);
            },
            onDismissed: (direction) {
              setState(() {
                entries.removeAt(index);
              });
            },
            child: _journalTile(entries[index], index),
          ),
    );
  }

  Widget _buildAddEntryButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
      child: GestureDetector(
        onTap: () => _showJournalDialog(context),
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: MyColors.color2,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Opacity(
                  opacity: 1,
                  child: Icon(
                      Icons.add, size: 15, color: Colors.white, weight: 800),
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                'ADD GRATITUDE ENTRY',
                style: TextStyle(fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Rounded corners
          titlePadding: const EdgeInsets.all(16),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Delete Entry',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context, false),
                child: const Icon(Icons.close, color: Colors.black54, size: 20),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          content: const Text(
            'Are you sure you want to delete this entry?',
            style: TextStyle(fontSize: 16),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          actions: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context, false),
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
                    onTap: () => Navigator.pop(context, true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.color2),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: MyColors.color2, fontSize: 14, fontWeight: FontWeight.w500),
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

  Widget _journalTile(String entry, int index) {
    return GestureDetector(
      onTap: () => _editJournalEntry(context, index),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyColors.color1.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            const Icon(Icons.favorite, color: Colors.redAccent, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                entry,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showJournalDialog(BuildContext context, {int? index}) {
    TextEditingController _controller = TextEditingController();
    if (index != null) {
      _controller.text = journalEntries[currentDate]![index];
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                index == null ? 'Add Gratitude Entry' : 'Edit Gratitude Entry',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Colors.red),
              ),
            ],
          ),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'I am grateful for...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  journalEntries[currentDate] ??= [];
                  if (index == null) {
                    journalEntries[currentDate]!.add(_controller.text);
                  } else {
                    journalEntries[currentDate]![index] = _controller.text;
                  }
                });
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: MyColors.color2,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _editJournalEntry(BuildContext context, int index) {
    _showJournalDialog(context, index: index);
  }
  Future<void> selectDate(BuildContext context) async {
    // Ensure static data is loaded
    _addStaticData();

    // Set selectedMonth to the current month
    selectedMonth = DateTime.now();

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        final daysInMonth = DateUtils.getDaysInMonth(selectedMonth.year, selectedMonth.month);
        final firstDay = DateTime(selectedMonth.year, selectedMonth.month, 1);
        String selectedDate = currentDate; // Store selected date locally for modal updates

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat('MMMM y').format(selectedMonth),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 250,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: daysInMonth + (firstDay.weekday - 1),
                      itemBuilder: (context, index) {
                        if (index < firstDay.weekday - 1) return Container();
                        final day = index - (firstDay.weekday - 1) + 1;
                        final date = DateTime(selectedMonth.year, selectedMonth.month, day);
                        final formattedDate = DateFormat('yyyy-MM-dd').format(date);
                        final hasEntry = journalEntries.containsKey(formattedDate);
                        final isSelected = selectedDate == formattedDate;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDate = formattedDate; // Update modal state
                            });
                          },
                          child: CalendarDay(
                            day: day,
                            hasEntry: hasEntry,
                            isSelected: isSelected,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      if (selectedDate.isNotEmpty) {
                        setState(() {
                          currentDate = selectedDate; // Update main state
                        });

                        // Reload UI in main state
                        if (mounted) {
                          this.setState(() {}); // Reload journal data for new date
                        }

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Selected Date: $selectedDate"),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                        color: MyColors.color2,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            spreadRadius: 1,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Text(
                        "Check Date",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }}