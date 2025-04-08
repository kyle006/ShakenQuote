import 'package:flutter/material.dart';
import 'screens/quote_screen.dart';

/// The entry point of the application. This runs the app and initializes the
/// main screen.
void main() {
  runApp(const ShakenQuoteApp());
}

/// The main app widget that sets up the theme and the home screen.
class ShakenQuoteApp extends StatelessWidget {
  /// Creates an instance of [ShakenQuoteApp].
  const ShakenQuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShakenQuote',  // Title of the app
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',  // Set default font
      ),
      home: const QuoteScreen(),  // The home screen of the app
      debugShowCheckedModeBanner: false,  // Hide the debug banner
    );
  }
}
