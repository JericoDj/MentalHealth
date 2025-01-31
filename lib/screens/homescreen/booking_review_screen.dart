import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/widgets/navigation_bar.dart';
import 'package:signature/signature.dart';
import '../../widgets/homescreen_widgets/eSignPopup.dart';
import '../../utils/constants/colors.dart';

class BookingReviewScreen extends StatefulWidget {
  final String consultationType;
  final String selectedDate;
  final String selectedTime;
  final String service;

  const BookingReviewScreen({
    Key? key,
    required this.consultationType,
    required this.selectedDate,
    required this.selectedTime,
    required this.service,
  }) : super(key: key);

  @override
  State<BookingReviewScreen> createState() => _BookingReviewScreenState();
}

class _BookingReviewScreenState extends State<BookingReviewScreen> {
  bool _isContractChecked = false;
  bool _hasViewedContract = false; // Ensures users view contract before agreeing
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
  );

  Uint8List? _signatureImage;

  void _openESignPopup() async {
    await showDialog(
      context: context,
      builder: (context) => ESignPopup(signatureController: _signatureController),
    );

    if (_signatureController.isNotEmpty) {
      final signature = await _signatureController.toPngBytes();
      setState(() {
        _signatureImage = signature;
      });
    }
  }

  void _openContractPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("E-Contract", style: TextStyle(fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _hasViewedContract = true; // Mark contract as viewed
                  });
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.close, color: Colors.redAccent),
              ),
            ],
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: SingleChildScrollView(
              child: const Text(
                "This e-contract contains the full agreement terms for your consultation.\n\n"
                    "**Clause 1: Terms and Conditions**\n"
                    "All users must adhere to the rules outlined in this contract.\n\n"
                    "**Clause 2: Service Agreement**\n"
                    "This agreement details the services provided and the obligations of each party.\n\n"
                    "**Clause 3: Obligations of Both Parties**\n"
                    "You agree to provide accurate information. The service provider commits to delivering services as outlined.\n\n"
                    "**Clause 4: Limitation of Liability**\n"
                    "The service provider is not responsible for external factors affecting your consultation.\n\n"
                    "**Clause 5: Termination and Refund Policy**\n"
                    "Cancellations must be made within 24 hours. Refunds are subject to our policy.\n\n"
                    "**Clause 6: Other Legal Details**\n"
                    "This contract is legally binding. Any disputes must be resolved according to our stated policy.",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _hasViewedContract = true; // Mark contract as viewed
                });
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: MyColors.white),
                  color: MyColors.color1
                ),
                child: Text(
                  "I've Read",
                  style: TextStyle(color: MyColors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _toggleAgreement(bool? value) {
    if (!_hasViewedContract) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please view the E-Contract before agreeing."),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
    } else {
      setState(() {
        _isContractChecked = value!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 65,
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.2),
          title: const Text("Review and Submit", style: TextStyle(color: MyColors.color1)),
          iconTheme: IconThemeData(color: MyColors.color1),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text("Review Your Booking Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFfcbc1d), Color(0xFFfd9c33), Color(0xFF59b34d), Color(0xFF359d4e)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: 350,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Text("Consultation Type: ${widget.consultationType}", style: TextStyle(color: MyColors.black, fontWeight: FontWeight.w600)),
                      Text("Date: ${widget.selectedDate}", style: TextStyle(color: MyColors.black, fontWeight: FontWeight.w600)),
                      Text("Time: ${widget.selectedTime}", style: TextStyle(color: MyColors.black, fontWeight: FontWeight.w600)),
                      Text("Service: ${widget.service}", style: TextStyle(color: MyColors.black, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("E-Contract", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _openContractPopup,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFfcbc1d), Color(0xFFfd9c33), Color(0xFF59b34d), Color(0xFF359d4e)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    child: const Text("Tap to view the full e-contract.", style: TextStyle(fontSize: 14)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    activeColor: MyColors.color2,
                    value: _isContractChecked,
                    onChanged: _toggleAgreement,
                  ),
                  const Text("I agree to the e-contract.", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _openESignPopup,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFfcbc1d), Color(0xFFfd9c33), Color(0xFF59b34d), Color(0xFF359d4e)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    child: _signatureImage != null
                        ? Image.memory(_signatureImage!, width: 200, height: 100, fit: BoxFit.contain)
                        :  Container(
                        width: 200, height: 100,
                        child: Center(child: Text("Tap to Sign", style: TextStyle(color: Colors.grey)))),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.offAll(()=> NavigationBarMenu(dailyCheckIn: false,));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(color: MyColors.color2, borderRadius: BorderRadius.circular(8)),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Text("Submit Request", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
