import 'package:cloud_firestore/cloud_firestore.dart';

class Consultation {
  final String serviceType;
  final String serviceId;
  final String status;
  final String bookedDate;
  final String bookedTime;
  final String createdDate;
  final String createdTime;

  Consultation({
    required this.serviceType,
    required this.serviceId,
    required this.status,
    required this.bookedDate,
    required this.bookedTime,
    required this.createdDate,
    required this.createdTime,
  });

  /// **🔥 Create `Consultation` Object from Firestore Document**
  factory Consultation.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Consultation(
      serviceType: data['service'] ?? 'Unknown Service',
      serviceId: data['consultation_id'] ?? '',
      status: data['status'] ?? 'Unknown',
      bookedDate: data['date_requested'] ?? 'N/A',
      bookedTime: data['time'] ?? 'N/A',
      createdDate: (data['created_at'] != null)
          ? (data['created_at'] as Timestamp).toDate().toString()
          : 'N/A',
      createdTime: '', // Can add logic for formatting time
    );
  }
}
