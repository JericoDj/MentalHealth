import 'package:get/get.dart';
import '../data/consultation data.dart';
import '../models/consultation_models.dart';

class ConsultationController extends GetxController {
  var consultations = <Consultation>[].obs;

  @override
  void onInit() {
    fetchConsultations();
    super.onInit();
  }

  /// Fetch all consultations
  void fetchConsultations() {
    consultations.assignAll([
      ...getConsultationData(0),
      ...getConsultationData(1),
      ...getConsultationData(2),
    ]);

    // Debugging to verify if data is fetched
    consultations.forEach((item) {
      print('Fetched: ${item.serviceType} - ${item.status}');
    });
  }

  /// Calculate pending count dynamically
  int get calculatePendingCount {
    fetchConsultations(); // Fetch updated consultations before calculating
    return consultations
        .where((item) => item.status.toLowerCase() == "pending")
        .length;
  }

  /// Calculate scheduled count dynamically
  int get calculateScheduledCount {
    fetchConsultations(); // Fetch updated consultations before calculating

    return consultations
        .where((item) => item.status.toLowerCase() == "scheduled")
        .length;
  }

  /// Calculate finished count dynamically
  /// Calculate finished count dynamically
  int get calculateFinishedCount {
    fetchConsultations(); // Fetch updated consultations before calculating
    return consultations
        .where((item) => item.status.toLowerCase() == "completed")
        .length;
  }

}