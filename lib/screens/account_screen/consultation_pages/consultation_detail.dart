import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String serviceType;
  final String serviceId;
  final String status;
  final String bookedDate;
  final String bookedTime;
  final String createdDate;
  final String createdTime;

  const DetailPage({
    required this.serviceType,
    required this.serviceId,
    required this.status,
    required this.bookedDate,
    required this.bookedTime,
    required this.createdDate,
    required this.createdTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(serviceType),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Consultation Details',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Service Type: $serviceType',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Service ID: $serviceId',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Status: $status',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Booked Date: $bookedDate',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Booked Time: $bookedTime',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Created Date: $createdDate',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Created Time: $createdTime',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to List'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
