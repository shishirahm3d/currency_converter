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
class ConversionHistoryScreen extends StatefulWidget {
  @override
  _ConversionHistoryScreenState createState() => _ConversionHistoryScreenState();
}

class _ConversionHistoryScreenState extends State<ConversionHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Conversion History',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFFF72585),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              _clearConversionHistory(context);
            },
            icon: Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF280F8F),
      body: ListView.builder(
        itemCount: conversionHistoryList.length,
        itemBuilder: (context, index) {
          final item = conversionHistoryList[index];
          return ListTile(
            title: Text(
              item.conversionDetails,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            subtitle: Text(
              'Date: ${item.date}, Time: ${item.time}',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        },
      ),
    );
  }

  void _clearConversionHistory(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Clearing History'),
        content: SizedBox(
          width: 30,
          height: 30,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );

    await Future.delayed(Duration(seconds: 2)); // Simulate a delay
    conversionHistoryList.clear();
    Navigator.pop(context);

    // Reload the page
    setState(() {});
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

void main() {
  runApp(MaterialApp(
    home: ConversionHistoryScreen(),
  ));
}
