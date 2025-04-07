import 'package:flutter/material.dart';
import 'screens/quote_screen.dart';

void main() {
  runApp(const ShakenQuoteApp());
}

class ShakenQuoteApp extends StatelessWidget {
  const ShakenQuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShakenQuote',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const QuoteScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
