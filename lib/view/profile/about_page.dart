import 'package:flutter/material.dart';

// Widget class
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
        iconTheme: IconThemeData(color: Colors.white), // Set the back icon color to white
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
          SizedBox(height: 20), // Add spacing between team member and description
          _buildAboutTheApp(), // Add the about the app description
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

  Widget _buildAboutTheApp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Center align the children
      children: [
        Text(
          'About The App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
            decoration: TextDecoration.underline,
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          'Currency Converter is your ultimate tool for real-time currency conversion and financial '
              'management on the go. Developed by Shishir Ahmed Midul, this intuitive mobile application '
              'combines cutting-edge technology with user-friendly design to provide you with a seamless '
              'currency conversion experience.\n\n'
              'With Currency Converter, you can:\n'
              'Stay Updated: Access real-time currency rates for all countries, ensuring you have the latest information at your fingertips.\n\n'
              'Convert with Ease: Effortlessly convert currencies from any country to another with just a few taps. Our app fetches real-time exchange rates from trusted APIs, ensuring accuracy and reliability.\n\n'
              'Track Your Transactions: Keep a record of your conversion history, including date and time stamps, so you can monitor your financial activities with ease.\n\n'
              'Secure Authentication: Enjoy peace of mind with our secure authentication system, including options for login, signup, and password recovery. Guest login is also available for those who prefer anonymity.',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.justify, // Justify the text
        ),
      ],
    );
  }
}
