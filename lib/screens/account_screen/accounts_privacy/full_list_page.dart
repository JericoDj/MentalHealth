import 'package:flutter/material.dart';

import '../../../models/consultation_models.dart';

class FullListPage extends StatelessWidget {
  final String title;
  final List<Consultation> fullList;

  const FullListPage({required this.title, required this.fullList, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: fullList.length,
        itemBuilder: (context, index) {
          final item = fullList[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.serviceType,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Service ID: ${item.serviceId}'),
                Text('Status: ${item.status}'),
                Text('Booked Date: ${item.bookedDate}'),
                Text('Booked Time: ${item.bookedTime}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
