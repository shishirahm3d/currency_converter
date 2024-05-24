import 'package:flutter/material.dart';
import 'package:currency_converter/api/rates_model.dart';
import 'package:currency_converter/api/api_services.dart';

class CurrencyRatesScreen extends StatefulWidget {
  const CurrencyRatesScreen({Key? key}) : super(key: key);

  @override
  _CurrencyRatesScreenState createState() => _CurrencyRatesScreenState();
}

class _CurrencyRatesScreenState extends State<CurrencyRatesScreen> {
  late Future<RatesModel> ratesModel;

  @override
  void initState() {
    super.initState();
    ratesModel = fetchRates(); // Fetch currency rates from the API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Currency Rates',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFFF72585), // Set app bar color
        actions: [
          IconButton(
            onPressed: () {
              _reloadRates(); // Reload rates when the reload icon is pressed
            },
            icon: Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF280F8F), // Set background color
      body: FutureBuilder<RatesModel>(
        future: ratesModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            // Display currency rates
            return ListView.builder(
              itemCount: snapshot.data!.rates.length,
              itemBuilder: (context, index) {
                String currencyCode = snapshot.data!.rates.keys.elementAt(index);
                double exchangeRate = snapshot.data!.rates.values.elementAt(index);
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // Transparent background
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$currencyCode',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        '${exchangeRate.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  // Function to reload currency rates
  void _reloadRates() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing the dialog
      builder: (context) => AlertDialog(
        title: Text('Updating Rates'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Getting updated rates from the exchangesite'),
          ],
        ),
      ),
    );

    setState(() {
      ratesModel = fetchRates().then((value) {
        Navigator.pop(context); // Close the dialog when rates are updated
        return value; // Return the fetched rates
      });
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: CurrencyRatesScreen(),
    theme: ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFF72585),
      ),
      scaffoldBackgroundColor: const Color(0xFF280F8F),
    ),
  ));
}
