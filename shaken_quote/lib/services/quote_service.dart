import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../models/quote.dart';

/// Service for fetching random quotes from the ZenQuotes API.
class QuoteService {
  final Logger _logger = Logger();

  /// Fetches a random quote from the ZenQuotes API.
  Future<Quote> getRandomQuote() async {
    final Uri url = Uri.parse('http://zenquotes.io/api/random');
    try {
      final http.Response response = await http.get(url);
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return Quote.fromJson(jsonList[0]);
      } else {
        throw Exception('Error loading quote');
      }
    } catch (e) {
      _logger.e('Error during API request: $e');
      return Quote(
        text: 'Keep going. Everything you need will come to you at the '
            'perfect time.',
        author: 'Unknown',
);
    }
  }
}