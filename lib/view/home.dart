import 'package:currency_convertor/api/rates_model.dart';
import 'package:currency_convertor/view/widgets/conversion_card.dart';
import 'package:currency_convertor/api/api_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<RatesModel> ratesModel;
  late Future<Map> currenciesModel;
  bool showMessage = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _showMessageAfterDelay();
  }

  Future<void> _fetchData() async {
    ratesModel = fetchRates();
    currenciesModel = fetchCurrencies();
  }

  Future<void> _showMessageAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      showMessage = true;
    });
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      showMessage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const Icon(Icons.currency_exchange, color: Colors.white), // Set the icon color to white
        title: const Text(
          'Currency Converter',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white // Make the title text bold
          ),
        ),
        backgroundColor: const Color(0xFFF72585),
        titleSpacing: -5,
      ),
      backgroundColor: Color(0xFF280F8F), // Set the background color using HEX value
      body: FutureBuilder<RatesModel>(
        future: ratesModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return FutureBuilder<Map>(
              future: currenciesModel,
              builder: (context, index) {
                if (index.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (index.hasError) {
                  return Center(child: Text('Error: ${index.error}'));
                } else if (index.data == null) {
                  return const Center(child: Text('No data available'));
                } else {
                  return Column(
                    children: [
                      if (showMessage) // Show message conditionally
                        const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            'Realtime market data loaded.\nYou can turn off your mobile data.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      Expanded(
                        child: ConversionCard(
                          rates: snapshot.data!.rates,
                          currencies: index.data!,
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
