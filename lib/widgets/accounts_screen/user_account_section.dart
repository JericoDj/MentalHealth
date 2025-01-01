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
            radius: 30,
            backgroundImage:
            NetworkImage('https://via.placeholder.com/150'),
          ),
          SizedBox(width: 16),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Company Name',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '500',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Followers',style: TextStyle(
                        fontSize: 12,
                      ),),
                    ],
                  ),
                  SizedBox(width: 20),
                  Row(
                    children: [
                      Text(
                        '200',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Following',style: TextStyle(fontSize: 10),),
                    ],
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
