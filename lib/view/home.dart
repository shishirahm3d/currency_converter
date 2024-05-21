import 'package:currency_converter/api/rates_model.dart';
import 'package:currency_converter/view/widgets/conversion_card.dart';
import 'package:currency_converter/api/api_services.dart';
import 'package:currency_converter/view/conversion_history.dart';
import 'package:currency_converter/view/currency_rates.dart';
import 'package:currency_converter/view/about.dart';
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
  int _selectedIndex = 0;

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
    _showMessageAfterDelay();
    _screens.addAll([
      HomeContentScreen(showMessage: showMessage),
      _buildConversionHistoryScreen(),
      _buildCurrencyRatesScreen(),
      _buildAboutUsScreen(),
    ]);
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

  Widget _buildConversionHistoryScreen() {
    return ConversionHistoryScreen();
  }

  Widget _buildCurrencyRatesScreen() {
    return CurrencyRatesScreen();
  }

  Widget _buildAboutUsScreen() {
    return AboutUsScreen();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0), // Hide the AppBar
        child: AppBar(
          automaticallyImplyLeading: false, // Hide back button or menu icon
          elevation: 0, // Remove elevation/shadow
          title: null, // Remove the title widget
        ),
      ),
      body: _screens[_selectedIndex], // Display selected screen
      extendBodyBehindAppBar: true, // Extend body behind AppBar
      extendBody: true, // Extend body to avoid bottom overflow
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Add border radius
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFFF72585), // Set selected item color
          unselectedItemColor: const Color(0xFFF72585), // Set unselected item color
          backgroundColor: Colors.white, // Background color of BottomNavigationBar
          elevation: 10, // Elevation of BottomNavigationBar
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Rates',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContentScreen extends StatelessWidget {
  final bool showMessage;

  const HomeContentScreen({Key? key, required this.showMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const Icon(Icons.currency_exchange, color: Colors.white), // Set the icon color to white
        title: const Text(
          'Currency Converter',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, // Make the title text bold
              fontFamily: 'Roboto-Regular',
              fontSize: 26
          ),
        ),
        backgroundColor: const Color(0xFFF72585),
        titleSpacing: -5,
      ),
      backgroundColor: const Color(0xFF280F8F), // Set the background color using HEX value
      body: FutureBuilder<RatesModel>(
        future: fetchRates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return FutureBuilder<Map>(
              future: fetchCurrencies(),
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
