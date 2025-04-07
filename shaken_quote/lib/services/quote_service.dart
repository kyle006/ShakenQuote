import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quote.dart';

class QuoteService {
  Future<Quote> getRandomQuote() async {
    final url = Uri.parse('http://zenquotes.io/api/random');
    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return Quote.fromJson(jsonList[0]);
      } else {
        throw Exception('Fehler beim Laden des Zitats');
      }
    } catch (e) {
      print('Fehler bei der API-Anfrage: $e');
      return Quote(
        text: 'Keep going. Everything you need will come to you at the perfect time.',
        author: 'Unknown',
      );
    }
  }
}
