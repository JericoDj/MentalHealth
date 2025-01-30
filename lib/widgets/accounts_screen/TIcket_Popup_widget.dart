import 'package:flutter/material.dart';

class SupportTicketsPage extends StatefulWidget {
  @override
  _SupportTicketsPageState createState() => _SupportTicketsPageState();
}

class _SupportTicketsPageState extends State<SupportTicketsPage> {
  final TextEditingController _ticketTitleController = TextEditingController();
  final TextEditingController _ticketDetailsController = TextEditingController();
  List<Map<String, String>> submittedTickets = [
    {'title': 'Login Issue', 'details': 'Unable to log in to the app since last update.', 'status': 'Open'},
    {'title': 'App Crash', 'details': 'App crashes when accessing the profile page.', 'status': 'In Progress'},
    {'title': 'Feature Request', 'details': 'Request to add dark mode feature.', 'status': 'Closed'},
    {'title': 'Payment Error', 'details': 'Payment not processing for premium plan.', 'status': 'Open'},
    {'title': 'Feedback', 'details': 'Great app, but more resources on anxiety needed.', 'status': 'Resolved'},
  ];

  void _submitTicket() {
    if (_ticketTitleController.text.isNotEmpty && _ticketDetailsController.text.isNotEmpty) {
      setState(() {
        submittedTickets.add({
          'title': _ticketTitleController.text,
          'details': _ticketDetailsController.text,
          'status': 'Open',
        });
        _ticketTitleController.clear();
        _ticketDetailsController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Tickets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 350,
              child: ListView.builder(
                itemCount: submittedTickets.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _getStatusColor(submittedTickets[index]['status']!),
                        child: const Icon(Icons.support_agent, color: Colors.white),
                      ),
                      title: Text(
                        submittedTickets[index]['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Status: ${submittedTickets[index]['status']}',
                        style: TextStyle(color: _getStatusColor(submittedTickets[index]['status']!)),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TicketDetailPage(ticket: submittedTickets[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Submit a Support Ticket',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _ticketTitleController,
              decoration: const InputDecoration(hintText: 'Ticket Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _ticketDetailsController,
              decoration: const InputDecoration(hintText: 'Describe your issue...'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                ElevatedButton(
                  onPressed: _submitTicket,
                  child: const Text('Submit'),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Open':
        return Colors.orange;
      case 'In Progress':
        return Colors.blue;
      case 'Resolved':
        return Colors.green;
      case 'Closed':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}

class TicketDetailPage extends StatelessWidget {
  final Map<String, String> ticket;

  const TicketDetailPage({required this.ticket, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ticket['title']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(ticket['details']!),
      ),
    );
  }
}