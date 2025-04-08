import 'package:audioplayers/audioplayers.dart';
import 'package:logger/logger.dart';

/// Service for playing sound effects, such as success sounds.
class SoundService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Logger _logger = Logger();

  /// Initializes the sound player.
  void initialize() {
    // Optional: You can add initialization logic if needed
  }

  /// Plays the success sound.
  Future<void> playSuccessSound() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/success.mp3'));
    } catch (e) {
      _logger.e('Error playing sound: $e');
    }
  }

  /// Disposes the audio player to release resources.
  void dispose() {
    _audioPlayer.dispose();
  }
}