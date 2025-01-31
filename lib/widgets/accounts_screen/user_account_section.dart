import 'package:flutter/material.dart';

class UserAccountSection extends StatefulWidget {
  const UserAccountSection({
    super.key,
  });

  @override
  _UserAccountSectionState createState() => _UserAccountSectionState();
}

class _UserAccountSectionState extends State<UserAccountSection> {
  // Store the current avatar image
  String _avatarImage = 'assets/avatars/Avatar5.jpeg';

  void _showAvatarDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: const Text("Choose Avatar")),
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Make it scrollable horizontally
            child: Row(
              children: [
                // Create a list of avatar options
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _avatarImage = 'assets/avatars/Avatar1.jpeg';
                    });
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage('assets/avatars/Avatar1.jpeg'),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _avatarImage = 'assets/avatars/Avatar2.jpeg';
                    });
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage('assets/avatars/Avatar2.jpeg'),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _avatarImage = 'assets/avatars/Avatar3.jpeg';
                    });
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage('assets/avatars/Avatar3.jpeg'),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _avatarImage = 'assets/avatars/Avatar4.jpeg';
                    });
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage('assets/avatars/Avatar4.jpeg'),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _avatarImage = 'assets/avatars/Avatar5.jpeg';
                    });
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage('assets/avatars/Avatar5.jpeg'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        children: [
          // Make CircleAvatar clickable
          GestureDetector(
            onTap: _showAvatarDialog,
            child: CircleAvatar(
              radius: 36,
              backgroundImage: AssetImage(_avatarImage), // Dynamically update avatar
            ),
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
