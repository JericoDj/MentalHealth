import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GratitudeJournalingContainer extends StatefulWidget {
  @override
  _GratitudeJournalingContainerState createState() =>
      _GratitudeJournalingContainerState();
}

class _GratitudeJournalingContainerState
    extends State<GratitudeJournalingContainer> {
  Map<String, List<String>> journalEntries = {};
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  Set<String> selectedEntries = Set();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GRATITUDE\nJOURNALING',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.lightGreenAccent,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Write three things you\'re thankful for each day.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 20),
          _journalNavigator(),
          const SizedBox(height: 10),
          _journalListView(),
          const SizedBox(height: 20),
          _addJournalButton(),
        ],
      ),
    );
  }

  Widget _journalNavigator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: _previousDay,
        ),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Text(
            DateFormat('MMMM d, yyyy').format(DateTime.parse(currentDate)),
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                decoration: TextDecoration.underline),
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
          onPressed: _nextDay,
        ),
      ],
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

  Widget _journalListView() {
    List<String> entries = journalEntries[currentDate] ?? [];
    return Column(
      children: entries.map((entry) => _journalTile(entry)).toList(),
    );
  }

  Widget _addJournalButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () => _showJournalDialog(context),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Add New Journal Entry',
            style: TextStyle(fontSize: 14),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
  Widget _journalTile(String entry) {
    bool isSelected = selectedEntries.contains(entry);

    return GestureDetector(
      onLongPress: () {
        setState(() {
          if (selectedEntries.contains(entry)) {
            selectedEntries.remove(entry);
          } else {
            selectedEntries.add(entry);
          }
        });
      },
      onTap: () => _showEditDialog(context, entry),
      child: Dismissible(
        key: Key(entry),
        direction: DismissDirection.endToStart,
        confirmDismiss: (DismissDirection direction) async {
          // Show confirmation dialog and wait for the result
          return await _confirmDelete(context, entry);
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blueGrey : Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(color: Colors.lightGreenAccent, width: 2)
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  entry,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              if (isSelected)
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () => _confirmDelete(context, entry),
                ),
            ],
          ),
        ),
      ),
    );
  }


  void _previousDay() {
    setState(() {
      DateTime previous =
      DateTime.parse(currentDate).subtract(Duration(days: 1));
      currentDate = DateFormat('yyyy-MM-dd').format(previous);
    });
  }

  void _nextDay() {
    setState(() {
      DateTime next = DateTime.parse(currentDate).add(Duration(days: 1));
      currentDate = DateFormat('yyyy-MM-dd').format(next);
    });
  }
  Future<bool?> _confirmDelete(BuildContext context, String entry) async {
    bool? confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Journal Entry'),
          content: Text('Are you sure you want to delete this entry?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),  // Dismiss without deleting
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  journalEntries[currentDate]?.remove(entry);
                  selectedEntries.remove(entry);
                });
                Navigator.pop(context, true);  // Confirm delete
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
    return confirm;  // Return result to Dismissible
  }


  /// New Method: Edit Journal Entry Dialog
  void _showEditDialog(BuildContext context, String entry) {
    TextEditingController _controller = TextEditingController(text: entry);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Journal Entry'),
          content: TextField(
            controller: _controller,
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  int index = journalEntries[currentDate]!.indexOf(entry);
                  journalEntries[currentDate]![index] = _controller.text;
                });
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _showJournalDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add to Gratitude Journal'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
                hintText: 'Write something you are grateful for...'),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  journalEntries[currentDate] ??= [];
                  journalEntries[currentDate]!.add(_controller.text);
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
