import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/login_signup/login_page.dart';



//Entry point with myapp function call
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Initialize Firebase asynchronously
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize Firebase and wait for completion
      future: initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Once Firebase is initialized, return MaterialApp
          return MaterialApp(
            title: 'Currency Converter',
            debugShowCheckedModeBanner: false,
            home: LoginPage(),
          );
        } else {
          // Show loading indicator while Firebase is initializing
          return CircularProgressIndicator();
        }
      },
    );
  }
}
