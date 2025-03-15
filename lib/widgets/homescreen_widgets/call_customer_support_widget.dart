import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/homescreen/calling_customer_support_screen.dart';
import '../../utils/constants/colors.dart';

class CallCustomerSupportPopup extends StatefulWidget {
  @override
  _CallCustomerSupportPopupState createState() => _CallCustomerSupportPopupState();
}

class _CallCustomerSupportPopupState extends State<CallCustomerSupportPopup> {
  bool _agreeToPrivacy = false;
  double _dragPosition = 0.0; // Drag position
  bool _dragReachedEnd = false; // Whether drag reached the end

  @override
  Widget build(BuildContext context) {
    // Fixed width for the slideable button
    double buttonWidth = 280.0; // Updated button width
    double draggableSize = 50.0; // Draggable icon size

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Call Customer Support"),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.close,
              color: MyColors.color2,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "To proceed with customer support, please agree to our data privacy policy.",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Checkbox(
                value: _agreeToPrivacy,
                activeColor: MyColors.color1, // Set checkbox color
                onChanged: (value) {
                  setState(() => _agreeToPrivacy = value!);
                },
              ),
              const SizedBox(width: 4), // Small space between checkbox and text
              Expanded(
                child: Text(
                  "I agree to the data privacy policy.",
                  style: TextStyle(
                    fontSize: 14,
                    color: MyColors.black, // Change text color
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Stack(
            children: [
              // The background button
              Container(
                width: buttonWidth,
                height: 50,
                decoration: BoxDecoration(
                  color: _agreeToPrivacy ? MyColors.color2 : Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Slide to Proceed",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              // The draggable button
              Positioned(
                left: _dragPosition,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    if (_agreeToPrivacy) {
                      setState(() {
                        _dragPosition += details.delta.dx;

                        // Constrain the draggable within the button bounds
                        if (_dragPosition < 0) {
                          _dragPosition = 0;
                          _dragReachedEnd = false;
                        } else if (_dragPosition > buttonWidth - draggableSize) {
                          _dragPosition = buttonWidth - draggableSize; // Adjust for draggable size
                          _dragReachedEnd = true; // Mark as reaching the end
                        } else {
                          _dragReachedEnd = false; // Reset if not at the end
                        }
                      });
                    }
                  },
                  onHorizontalDragEnd: (_) {
                    if (_dragReachedEnd) {
                      // Only navigate when the drag reaches the end
                      Navigator.of(context).pop(); // Close popup
                      Get.to(() => CallingCustomerSupportScreen(
                        roomId: null,
                        isCaller: true,  // ✅ Corrected this line (Removed `()` after `true`)
                      )); // Navigate to calling screen
                    } else {
                      // Reset the drag position if not completed
                      setState(() => _dragPosition = 0);
                    }
                  },
                  child: _buildDraggableIcon(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableIcon() {
    return Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.arrow_forward,
        color: MyColors.color1,
      ),
    );
  }
}
