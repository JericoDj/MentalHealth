import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';


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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFF8F8F8),
                      Color(0xFFF1F1F1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
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
                      stops: const [0.0, 0.5, 0.5, 1.0], // Define stops at 50% transition
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _ticketTitleController,
                decoration: const InputDecoration(hintText: 'Ticket Title', hintStyle: TextStyle(color: Colors.black54)),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _ticketDetailsController,
                decoration: const InputDecoration(hintText: 'Describe your issue...', hintStyle: TextStyle(color: Colors.black54)),
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _submitTicket,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 36),
                  decoration: BoxDecoration(
                    color: MyColors.color2,
                    borderRadius: BorderRadius.circular(8), // Add rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Open':
        return MyColors.color2;
      case 'In Progress':
        return MyColors.color1;
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
        backgroundColor: MyColors.color1,
        title: Text(ticket['title']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(ticket['details']!, style: const TextStyle(color: Colors.black87)),
      ),
    );
  }
}
