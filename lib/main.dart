import 'package:flutter/material.dart';
import 'package:currency_convertor/view/home.dart';
import 'package:currency_convertor/view/conversion_history.dart';
import 'package:currency_convertor/view/currency_rates.dart';
import 'package:currency_convertor/view/about_us.dart';

//Entry point with myapp function call
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto-Regular',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 26,
            fontFamily: 'Roboto-Regular',
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState(); //Calling class object
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ConversionHistoryScreen(),
    CurrencyRatesScreen(),
    AboutUsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {  //Building interface
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
