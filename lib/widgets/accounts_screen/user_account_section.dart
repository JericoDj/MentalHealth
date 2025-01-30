import 'package:flutter/material.dart';

class UserAccountSection extends StatelessWidget {
  const UserAccountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,10,10,0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundImage:
            AssetImage('assets/avatars/Avatar5.jpeg'),
          ),
          SizedBox(width: 16),
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 10),

                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Company Name',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}
