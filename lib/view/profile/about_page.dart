import 'package:flutter/material.dart';

//Widget class
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF72585), // Change app bar color
      ),
      backgroundColor: Color(0xFF280F8F),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildTeamMember(
            name: 'Shishir Ahmed Midul',
            id: '213-15-14776',
            section: '60_A',
            dept: 'CSE',
            imageUrl: 'assets/images/shishir.png',
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember({
    required String name,
    required String id,
    required String section,
    required String dept,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundImage: AssetImage(imageUrl),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'ID: $id',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Section: $section',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Dept: $dept',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

