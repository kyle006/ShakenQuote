/// Represents a motivational quote with text and author.
class Quote {
  /// Creates a [Quote] with the given [text] and [author].
  Quote({required this.text, required this.author});

  /// Creates a [Quote] from a JSON object.
  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      text: json['q'] ?? 'No quote found.',
      author: json['a'] ?? 'Unknown',
    );
  }

  /// The text of the quote.
  final String text;

  /// The author of the quote.
  final String author;
}
