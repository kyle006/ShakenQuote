import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/quote.dart';
import '../services/quote_service.dart';
import '../services/sound_service.dart';
import '../services/shake_service.dart';

/// This screen displays a motivational quote and allows the user to shake
/// the device for a new quote.
class QuoteScreen extends StatefulWidget {
  /// Creates a [QuoteScreen] widget.
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  /// The current quote that is being displayed.
  Quote? currentQuote;

  /// Indicates whether the app is loading a new quote.
  bool isLoading = true;

  /// The service used to fetch quotes.
  final QuoteService _quoteService = QuoteService();

  /// The service used to play sound effects.
  final SoundService _soundService = SoundService();

  /// The service used to detect shake gestures.
  late ShakeService _shakeService;

  @override
  void initState() {
    super.initState();
    
    try {
      _soundService.initialize();
    } catch (e) {
      debugPrint('Error initializing sound service: $e');
    }
    
    try {
      _shakeService = ShakeService();
      _shakeService.startListening(() {
        if (!isLoading) {
          fetchNewQuote();
        }
      });
    } catch (e) {
      debugPrint('Error initializing shake detection: $e');
    }
    
    fetchNewQuote();
  }

  @override
  void dispose() {
    _shakeService.stopListening();
    _soundService.dispose();
    super.dispose();
  }

  /// Fetches a new random quote and updates the state.
  Future<void> fetchNewQuote() async {
    setState(() {
      isLoading = true;
    });

    try {
      final Quote newQuote = await _quoteService.getRandomQuote();
      _updateQuoteState(newQuote);
      await _playSoundFeedback();
    } catch (e) {
      debugPrint('Error in fetchNewQuote: $e');
      _handleQuoteError(e);
    }
  }

  /// Updates the state with the new quote and sets [isLoading] to false.
  void _updateQuoteState(Quote quote) {
    if (mounted) {
      setState(() {
        currentQuote = quote;
        isLoading = false;
      });
    }
  }

  /// Plays sound feedback after fetching a new quote.
  Future<void> _playSoundFeedback() async {
    try {
      await _soundService.playSuccessSound();
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  /// Handles errors by displaying them in a SnackBar.
  void _handleQuoteError(dynamic error) {
    if (mounted) {
      setState(() {
        isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildGradientBackground(),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 40),
                  Text(
                    'ShakenQuote',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                  
                  Expanded(
                    child: Center(
                      child: isLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : _buildQuoteContainer(),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Text(
                      'Shake the device for a new quote',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: _buildGlassButton(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the gradient background for the screen.
  Widget _buildGradientBackground() {
    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color.fromARGB(255, 68, 83, 117),
                Color.fromARGB(255, 91, 136, 221),
              ],
            ),
          ),
        ),
        
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF6B80AC).withOpacity(0.2), 
            ),
          ),
        ),
        
        Positioned(
          bottom: -80,
          right: -80,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF4A5D82).withOpacity(0.2),
            ),
          ),
        ),
        
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 40.0, 
            sigmaY: 40.0,
          ),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }

  /// Builds the container for the current quote.
  Widget _buildQuoteContainer() {
    if (currentQuote == null) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.white.withOpacity(0.25),
                Colors.white.withOpacity(0.10),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
              width: 1.5,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                currentQuote!.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                '- ${currentQuote!.author}',
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.white.withOpacity(0.95),
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the glass-like button for fetching a new quote.
  Widget _buildGlassButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: InkWell(
          onTap: isLoading ? null : fetchNewQuote,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.white.withOpacity(0.25),
                  Colors.white.withOpacity(0.15),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.4),
                width: 1.5,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Text(
              'New Quote',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.95),
                shadows: <Shadow>[
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}