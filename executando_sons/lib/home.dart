import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AudioPlayer _player = AudioPlayer();
  bool playing = false;
  double volume = 0.5;

  @override
  void dispose() {
    super.dispose();
    _player.release();
  }

  _playSound() async {
    if ( ! playing ) {
      await  _player.play(AssetSource('sounds/musica.mp3'));
      playing = true;
    } else {
      await _player.resume();
    }
  }

  _stopSound() async {
    await _player.stop();
    playing = false;
  }

  _pauseSound() async {
    await _player.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Executando sons'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Slider(
              value: volume,
              onChanged: (newVolume) {
                setState(() {
                  volume = newVolume;
                });
                _player.setVolume(volume);
              },
              divisions: 10,
              min: 0,
              max: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _playSound(),
                  child: Image.asset('images/executar.png'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () => _pauseSound(),
                    child: Image.asset('images/pausar.png'),
                  ),
                ),
                GestureDetector(
                  onTap: () => _stopSound(),
                  child: Image.asset('images/parar.png'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}