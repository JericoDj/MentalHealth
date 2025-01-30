import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';
import '../../controllers/consultation_controller.dart';
import '../../data/consultation data.dart';
import '../../models/consultation_models.dart';
import '../../screens/account_screen/accounts_privacy/full_list_page.dart';
import '../../screens/account_screen/consultation_pages/consultation_detail.dart';

class ConsultationStatusWidget extends StatefulWidget {
  @override
  _ConsultationStatusWidgetState createState() =>
      _ConsultationStatusWidgetState();
}

class _ConsultationStatusWidgetState extends State<ConsultationStatusWidget> {
  final ConsultationController consultationController =
  Get.put(ConsultationController());
  String displayText = "Consultation Overview";
  List<Consultation> itemList = [];
  bool showList = false;

  @override
  void initState() {
    super.initState();
    updateDisplay(0);
  }

  void updateDisplay(int index) {
    setState(() {
      showList = true;
      itemList = getConsultationData(index);
      displayText = index == 0
          ? "Requests: You have ${itemList.length} pending requests."
          : index == 1
          ? "Scheduled: You have ${itemList.length} consultations scheduled."
          : "Finished: You have completed ${itemList.length} consultations.";
    });
  }

  void navigateToDetailPage(BuildContext context, Consultation consultation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(
          serviceType: consultation.serviceType,
          serviceId: consultation.serviceId,
          status: consultation.status,
          bookedDate: consultation.bookedDate,
          bookedTime: consultation.bookedTime,
          createdDate: consultation.createdDate,
          createdTime: consultation.createdTime,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white30,
              Colors.white24
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 30,
              runSpacing: 10,
              children: [
                _buildStatusIcon(
                  icon: Icons.request_page,
                  label: "Requests",
                  onTap: () => updateDisplay(0),
                  count: consultationController.calculatePendingCount.obs,  // Directly listening here
                ),
                _buildStatusIcon(
                  icon: Icons.schedule,
                  label: "Scheduled",
                  onTap: () => updateDisplay(1),
                  count: consultationController.calculateScheduledCount.obs,
                ),
                _buildStatusIcon(
                  icon: Icons.check_circle,
                  label: "Finished",
                  onTap: () => updateDisplay(2),
                  count: consultationController.calculateFinishedCount.obs,
                ),

              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.black38,
              ),
              height: 350,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: itemList.isEmpty
                        ? Center(
                      child: Text(
                        displayText.contains("Requests")
                            ? "No ongoing requests."
                            : displayText.contains("Scheduled")
                            ? "No scheduled consultations."
                            : "No finished consultations.",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                        : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        final item = itemList[index];
                        return GestureDetector(
                          onTap: () =>
                              navigateToDetailPage(context, item),
                          child: Container(
                            margin:
                            const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.serviceType,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(item.bookedDate),
                                    const Spacer(),
                                    Text(item.bookedTime),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: MyColors.color2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullListPage(
                                title: displayText,
                                fullList: itemList,
                              ),
                            ),
                          );
                        },
                        child: const Text("View All",style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildStatusIcon({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  required RxInt count,  // Add count parameter to show the number of requests/scheduled
}) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 30,
                color: MyColors.color1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        if (count > 0)  // Only show the badge if count is greater than zero
          Positioned(
            top: -5,
            right: -5,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: MyColors.color2,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
