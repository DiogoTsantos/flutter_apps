import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // .. Indica que o retorno do método chamado deve ser desconsiderado, retornando então o item anes do ..
    /*_controller = VideoPlayerController.networkUrl(
      Uri.parse('https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
    )..initialize().then((_) {
      setState(() {
        // o operador _ indica que o parametro é desconsiderado, não usando mémoria.
        _controller.play();
      });
    });*/

    _controller = VideoPlayerController.asset(
      'videos/video.mp4'
    )..setLooping(true)
    ..initialize().then((_) {
      setState(() {
        // _controller.play();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
          ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
          : const Text('Pressione o play'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play();
          });
        },
        child: Icon(
           _controller.value.isPlaying
           ? Icons.pause
           : Icons.play_arrow
        ),
      ),
    );
  }
}