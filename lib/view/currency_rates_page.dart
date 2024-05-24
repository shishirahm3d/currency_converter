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
        automaticallyImplyLeading: false, // Remove the back button
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
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Display currency rates
            return ListView.builder(
              itemCount: snapshot.data!.rates.length,
              itemBuilder: (context, index) {
                String currencyCode = snapshot.data!.rates.keys.elementAt(index);
                double exchangeRate = snapshot.data!.rates.values.elementAt(index);
                return ListTile(
                  title: Text(
                    '$currencyCode',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  subtitle: Text(
                    'Rate: $exchangeRate',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
