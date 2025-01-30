import 'package:flutter/material.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';

class ConsultationToggle extends StatelessWidget {
  final String selectedType;
  final Function(String) onToggle;

  const ConsultationToggle({
    Key? key,
    required this.selectedType,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        children: [

          Container(


            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: MyColors.color1
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(

                textAlign: TextAlign.center,
                'Service Type', style: TextStyle(



                  color: Colors.white,
                  fontSize: 18,fontWeight: FontWeight.bold),),
            ),),


          SizedBox(height: 5,),
          Row(
            children: [
              _buildToggleButton("Online"),
              _buildToggleButton("Face-to-Face"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String type) {
    final bool isSelected = selectedType == type;
    return Expanded(
      child: TextButton(
        onPressed: () => onToggle(type),
        child: Text(
          type,
          style: TextStyle(
            fontSize: isSelected? 18: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.green : Colors.grey,

          ),
        ),
      ),
    );
  }
}
