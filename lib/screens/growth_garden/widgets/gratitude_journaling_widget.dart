import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../utils/constants/colors.dart';

class GratitudeJournalWidget extends StatefulWidget {
  @override
  _GratitudeJournalWidgetState createState() => _GratitudeJournalWidgetState();
}

class _GratitudeJournalWidgetState extends State<GratitudeJournalWidget> {
  Map<String, List<String>> journalEntries = {};
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(3), // Border thickness
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), // Match inner radius
        gradient: const LinearGradient(
          colors: [MyColors.color1, Colors.green, Colors.orange, MyColors.color2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Inner content background
          borderRadius: BorderRadius.circular(14), // Slightly smaller to fit inside border
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
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                color: Colors.grey.withOpacity(0.15)
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
      decoration: BoxDecoration(
        color: Colors.white12
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Gratitude Journal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MyColors.color1,
              ),
            ),

            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: MyColors.color1),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: MyColors.color1,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [

                        Text(
                          DateFormat('MMM d, yyyy').format(DateTime.parse(currentDate)),
                          style: const TextStyle(color: Colors.white, fontSize: 14),
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
        padding: const EdgeInsets.symmetric(vertical: 20),
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
      itemBuilder: (context, index) => Dismissible(
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
        child: _journalTile(entries[index]),
      ),
    );
  }

  Widget _buildAddEntryButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
      child: GestureDetector(
        onTap: () => _showJournalDialog(context),
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(

            color: MyColors.color2,

          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Opacity(
                  opacity: 1, // Adjust opacity level (0.0 - fully transparent, 1.0 - fully opaque)
                  child: Icon(Icons.add, size: 15, color: Colors.white,weight: 800,),
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                'ADD GRATITUDE ENTRY',
                style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
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
          title: const Text('Delete Entry'),
          content: const Text('Are you sure you want to delete this entry?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Widget _journalTile(String entry) {
    return GestureDetector(
      onTap: () {
        // Add functionality if needed for tapping an entry
      },
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

  void _showJournalDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Gratitude Entry'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'I am grateful for...',
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  journalEntries[currentDate] ??= [];
                  journalEntries[currentDate]!.add(_controller.text);
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(currentDate),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.parse(currentDate)) {
      setState(() {
        currentDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}
