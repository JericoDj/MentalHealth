import '../data/consultation data.dart';
import '../models/consultation_models.dart';

class ConsultationRepository {
  Future<List<Consultation>> fetchConsultations() async {


    // Simulate delay to mimic API or database call
    await Future.delayed(const Duration(seconds: 1));

    // Fetching consultations
    return [
      ...getConsultationData(0),
      ...getConsultationData(1),
      ...getConsultationData(2),
    ];
  }
}
