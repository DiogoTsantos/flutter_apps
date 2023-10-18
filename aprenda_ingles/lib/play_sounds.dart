import 'package:audioplayers/audioplayers.dart';

class PlaySounds {
  final AudioPlayer _player = AudioPlayer();

  PlaySounds() {
    // _player.audioCache.prefix = 'sounds/';
  } 

  void play( String source) {
    _player.play(AssetSource('sounds/$source'));
  }

  void dispose() {
    _player.dispose();
  }
}