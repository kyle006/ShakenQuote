import 'package:audioplayers/audioplayers.dart';

class SoundService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void initialize() {
  }

  Future<void> playSuccessSound() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/success.mp3'));
    } catch (e) {
      print('Fehler beim Abspielen des Sounds: $e');
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
