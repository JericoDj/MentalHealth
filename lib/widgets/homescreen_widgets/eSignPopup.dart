import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class ESignPopup extends StatefulWidget {
  final SignatureController signatureController;

  const ESignPopup({Key? key, required this.signatureController})
      : super(key: key);

  @override
  _ESignPopupState createState() => _ESignPopupState();
}

class _ESignPopupState extends State<ESignPopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("E-Signature"),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, color: Colors.redAccent),
          ),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            const Text("Draw your signature below."),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Signature(
                  controller: widget.signatureController,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: widget.signatureController.clear,
          child: const Text("Clear"),
        ),
        TextButton(
          onPressed: () {
            if (widget.signatureController.isNotEmpty) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Signature saved!")),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please draw your signature.")),
              );
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
