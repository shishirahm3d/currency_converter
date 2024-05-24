import 'package:flutter/material.dart';

// Define a class to represent a conversion history item
class ConversionHistoryItem {
  final String conversionDetails;
  final String date;
  final String time;

  ConversionHistoryItem({
    required this.conversionDetails,
    required this.date,
    required this.time,
  });
}

// List to store conversion history items
List<ConversionHistoryItem> conversionHistoryList = [];

// Conversion History Screen Widget
class ConversionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Conversion History',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Make title font bold
        ),
        backgroundColor: const Color(0xFFF72585), // Set app bar background color
        automaticallyImplyLeading: false, // Disable the back button
      ),
      backgroundColor: const Color(0xFF280F8F), // Set background color
      body: ListView.builder(
        itemCount: conversionHistoryList.length,
        itemBuilder: (context, index) {
          final item = conversionHistoryList[index];
          return ListTile(
            title: Text(
              item.conversionDetails,
              style: TextStyle(color: Colors.white, fontSize: 20), // Set text color to white
            ),
            subtitle: Text(
              'Date: ${item.date}, Time: ${item.time}',
              style: TextStyle(color: Colors.white, fontSize: 16), // Set text color to white
            ),
          );
        },
      ),
    );
  }
}

// Function to add an item to the conversion history list
void addToConversionHistory(String conversionResult) {
  DateTime now = DateTime.now();
  String date = '${now.year}-${now.month}-${now.day}';
  String time = '${now.hour}:${now.minute}:${now.second}';
  conversionHistoryList.add(
    ConversionHistoryItem(
      conversionDetails: conversionResult,
      date: date,
      time: time,
    ),
  );
}
