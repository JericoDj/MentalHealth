import 'dart:typed_data'; // Correct import for Uint8List
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import '../../widgets/homescreen_widgets/eSignPopup.dart';

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

    // Capture the signature as an image after popup closes
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
              const Text("E-Contract"),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.close,
                  color: Colors.redAccent,
                ),
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
                "This is the full e-contract content. It contains all the terms and conditions you need to read and agree to.\n\n"
                    "Clause 1: Terms and Conditions\n"
                    "Clause 2: Service Agreement\n"
                    "Clause 3: Obligations of Both Parties\n"
                    "Clause 4: Limitation of Liability\n"
                    "Clause 5: Termination and Refund Policy\n"
                    "Clause 6: Other Legal Details.\n\n"
                    "Please scroll through and read all terms carefully.",
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("I've Read"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Review and Submit"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Review Your Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text("Consultation Type: ${widget.consultationType}"),
                  Text("Date: ${widget.selectedDate}"),
                  Text("Time: ${widget.selectedTime}"),
                  Text("Service: ${widget.service}"),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "E-Contract",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: _openContractPopup,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          "This is a preview of the e-contract. Tap to view the full version.\n\n"
                              "Clause 1: Terms and Conditions\n"
                              "Clause 2: Service Agreement\n"
                              "Clause 3: Obligations of Both Parties\n"
                              "Clause 4: Limitation of Liability\n"
                              "Clause 5: Termination and Refund Policy\n"
                              "Clause 6: Other Legal Details.\n\n",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: _isContractChecked,
                  onChanged: (value) {
                    setState(() => _isContractChecked = value!);
                  },
                ),
                const Text("I agree to the e-contract."),
              ],
            ),
            if (_isContractChecked)
              ElevatedButton(
                onPressed: _openESignPopup,
                child: const Text("Sign E-Contract"),
              ),
            if (_signatureImage != null) ...[
              const SizedBox(height: 20),
              const Text("Your Signature:", style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.memory(
                  _signatureImage!,
                  width: 200,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ],
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_isContractChecked && _signatureController.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Request submitted successfully!")),
                  );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please complete the e-contract and sign.")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                padding: const EdgeInsets.all(16),
              ),
              child: const Text(
                "Submit Request",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
